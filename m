Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CC6083634
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZMWS39U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1643410F673;
	Tue,  3 Nov 2026 15:33:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AA410F69A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:33:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4ADBE60A4A;
 Tue,  3 Nov 2026 15:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0742F1F00A1D;
 Tue,  3 Nov 2026 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719990;
 bh=stwNLc3KoDmAl6zbHmoeXZi9oqr+uZ42X423WQ2AJZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SZMWS39UrEkdV+pa0/unnbWXflB2/mEL/zhCdN11fHH02AIP/lHsWKTr/sofJtc8S
 y9SAHuKBqW/KzZY/0F0GlXmWcUb7zncXp+Jf5oiMalS1Fdd14mx4YdYx2fOJOZE+lx
 TGaAi41FwwbEip8IntAXct2Hg7J2fzMlL1tu3xYI/AjIqLWCmmbTB/FH93hne/9OlU
 7rYZi3QNfVP0U3TfgSTuJfNiKEbzH9t1FEEYNmfCkNxR5kLYReWMPcyv+Bg9N3syH+
 3i6NnS6d6uI0FTTHS0VfnJTkEBlOynZ2yGqy60muZ5I63VzLk5oaXMdoSJoXfGF9nj
 4dERxeAv9j55w==
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
Subject: [RFC PATCH v7 7/8] rust: drm: Add JobQueue
Date: Tue,  3 Nov 2026 16:31:37 +0100
Message-ID: <20261103153138.1087330-9-phasta@kernel.org>
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

JobQueue is a pure Rust component that handles job submissions for GPUs
with firmware scheduling, i.e., GPUs that support one exclusive ring per
execution context.

JobQueue's primary task is dependency handling, where the user can set
dependencies, each in the form of a `dma_buf::Fence`, on a job and then
submit it to the queue.

Jobs are being executed in order, following the FIFO principle. Only
jobs whose dependencies are all fulfilled get executed, otherwise the
JobQueue pauses.

A core design principle, just like with DmaFence, is to avoid all
allocations in job submission paths, since this runs danger of
deadlocking.

Another design principle, new when compared to the older drafts, is the
ownership relationship with fences:

  1. The JobQueue owns the FenceContext exclusively.
  2. Jobs are created on the JobQueue, ensuring correct fence sequence
     number ordering.
  3. Jobs own the respective DriverFence.
  4. Jobs are owned by the JobQueue.

Consequently, a driver can only interact with fences and FenceContext
indirectly through the JobQueue, and can also only complete jobs (and,
hence, signal fences) through the JobQueue.

Unfortunately, since jobs need a reference to the JobQueue for their
fence dependency objects (DependencyWaker), this code can currently not
be used in this form because some work on self-referential PinInit is
required. See the respective comments in the Example.

When a job shall be run, both its JobQueue::data and Job::data get
borrowed back to it, together with the sequence number of this job, so
that the driver can perform the appropriate interaction with the
hardware.

The submit_worker runs all ready jobs based on a credit count system, so
that run_job() can be infallible. The same worker drops jobs (and their
fences) that are already completed. Should this proof to be a
performance issue, a second worker could trivially be added for this.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Co-developed-by: Gary Guo <gary@garyguo.net>

(^ waiting for Gary to sign-off)
---
 rust/kernel/drm/job_queue.rs | 826 +++++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs       |   4 +
 2 files changed, 830 insertions(+)
 create mode 100644 rust/kernel/drm/job_queue.rs

diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
new file mode 100644
index 000000000000..e51adedaeddb
--- /dev/null
+++ b/rust/kernel/drm/job_queue.rs
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Red Hat Inc.
+ * Author: Philipp Stanner <pstanner@redhat.com>
+ */
+
+//! DRM's job dependency manager and load balancer for GPUs with firmware
+//! scheduling, i.e., GPUs that can spawn one ring exclusive per user context.
+//!
+//! JobQueue abstracts the entire handling of [`dma_buf::FenceContext`] and its
+//! associated [`dma_buf::DriverFence`]s for the user.
+//!
+//! In this design, a JobQueue is always the owner of a [`dma_buf::FenceContext`]
+//! which represents the timeline on the associated GPU ring. Jobs created on
+//! this JobQueue always contain a [`dma_buf::DriverFence`] from this JobQueue,
+//! where the fence sequence number corresponds with the job sequence number,
+//! and the fence's generic payload data is also the job's payload data. This
+//! allows for the dma_fence backend_ops callbacks interacting with the driver
+//! through JobQueue. The trait [`JobQueueOps`] is the interface between driver
+//! and fence backend_ops.
+//!
+//! [`Job`]s created on the [`JobQueue`] take over ownership of the user's data
+//! and prepare all memory allocations. A later job submission sets up the fence
+//! and performs no fallible operations.
+//!
+//! Before jobs are submitted to a queue, dependencies in the form of
+//! [`dma_buf::Fence`] can be set on them. Jobs are run by the JobQueue in
+//! process context through a work item in FIFO order. Only jobs whose
+//! dependency fences have all been signaled are run. If the front job's
+//! dependency is not yet fulfilled, the JobQueue pauses until that's the case.
+//!
+//! JobQueue implements a credit count system, where the queue itself gets
+//! assigned a capacity by the user, and jobs get assigned individual cost. Jobs
+//! get only pushed if there is enough capacity; if not, running stops until
+//! that is the case. These credits must accurately represent the capacity on
+//! the GPU ring the queue was created for.
+//!
+//! The driver tells the JobQueue which jobs are finished through
+//! [`JobQueue::complete_jobs_up_to_seqno()`]. This function is typically
+//! invoked through the driver's GPU interrupt handler.
+//!
+//! Since jobs might contain data that must not drop in atomic context, and
+//! since jobs' [`dma_buf::DriverFence`]s perform a call to
+//! [`rcu::synchronize_rcu()`], they are dropped through a work item if [`Drop`]
+//! is implemented for the job's payload data.
+//!
+//! From JobQueue's perspective, it is not necessary to call any of its API
+//! functions with a driver lock held; this is actually discouraged to reduce
+//! the probability of deadlocks. All JobQueue API functions are properly
+//! ordered using the internal lock.
+//!
+//! JobQueue tells drivers to run jobs through [`JobQueueOps::run_job`], which
+//! is called without the JobQueue's spinlock being held, i.e., the driver is
+//! permitted to perform sleeping operations in the callback. JobQueue handles
+//! races between `run_job` and [`JobQueueOps::complete_jobs_up_to_seqno()`].
+//!
+//! This is pure Rust code that does not directly abstract C.
+
+#![allow(clippy::multiple_bound_locations)] // Clippy false positive, to be addressed by pin-init.
+
+use core::{
+    convert::Infallible,
+    ops::Deref, //
+};
+
+use kernel::{
+    dma_buf::dma_fence::{
+        DriverFence,
+        DriverFenceAllocation,
+        Fence,
+        FenceCallback,
+        FenceCallbackRegistration,
+        FenceContext,
+        FenceContextOps, //
+    },
+    list::{
+        impl_list_arc_safe,
+        impl_list_item,
+        List,
+        ListItem,
+        ListLinks, //
+    },
+    new_srcu,
+    prelude::*,
+    str::CString,
+    sync::{
+        aref::ARef,
+        atomic::{
+            Atomic,
+            Relaxed, //
+        }, //
+        new_spinlock_irq,
+        SpinLockIrq,
+    }, //
+    sync::{
+        atomic::AtomicFlag,
+        Srcu, //
+    },
+    sync::{Arc, UniqueArc},
+    workqueue::{
+        self,
+        new_scoped_work,
+        //        ScopedQueue,
+        ScopedWork,
+        ScopedWorkItem,
+        ScopedWorkRef,
+    }, //
+};
+
+/// A linked list where all elements are owned.
+///
+/// This is a thin wrapper of `List` with all elements are `UniqueArc`.
+struct UniqueList<T: ListItem>(List<T>);
+
+impl<T: ListItem> Default for UniqueList<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: ListItem> UniqueList<T> {
+    fn new() -> Self {
+        Self(List::new())
+    }
+
+    fn push_front(&mut self, item: Pin<UniqueArc<T>>) {
+        self.0.push_front(item.into())
+    }
+
+    fn push_back(&mut self, item: Pin<UniqueArc<T>>) {
+        self.0.push_back(item.into())
+    }
+
+    fn pop_front(&mut self) -> Option<Pin<UniqueArc<T>>> {
+        Some(
+            Arc::into_unique_or_drop(self.0.pop_front()?.into_arc())
+                .expect("UniqueList should only contain UniqueArc"),
+        )
+    }
+}
+
+struct DependencyWaker<'b, 'nr_of_deps, T: JobQueueOps + Send + Sync> {
+    nr_of_deps: &'nr_of_deps Atomic<u32>,
+    jq: &'b JobQueue<T>,
+}
+
+impl<'b, T: JobQueueOps + Send + Sync> FenceCallback for DependencyWaker<'b, '_, T> {
+    fn on_signal(&mut self, res: Result) {
+        if let Err(err) = res {
+            // Dependencies are unfulfilled and will never be fulfilled. Halt the
+            // submit_worker and tell the driver to tear this JQ down.
+            self.jq.revoked.store(true, Relaxed);
+            self.jq.srcu.synchronize();
+
+            // TODO RFC:
+            // We likely want a work_item for this, don't we? Because the
+            // dma_fence backend is holding the lock.
+            T::kill(self.jq.fctx.deref(), self.jq.id(), err);
+        }
+
+        // Last dependency kicks the worker.
+        if self.nr_of_deps.fetch_sub(1, Relaxed) == 1 {
+            // The drop-order of JobQueue ensures that all DependencyWakers are
+            // cancelled before the JobQueue itself is dropped.
+            self.jq.check_start_submit_worker();
+        }
+    }
+}
+
+/// A JobQueue job before it has been submitted.
+///
+/// This is only useful for registering dependencies on and for submitting it.
+pub struct Job<'a, T: JobQueueOps + Send + Sync> {
+    inner: Pin<UniqueArc<JobInternal<'a, T>>>,
+    fence_allocation: DriverFenceAllocation<'a, DriverDataWrapper<T>>,
+}
+
+impl<'a, T: JobQueueOps + Send + Sync> Job<'a, T> {
+    /// Add a dependency for the job.
+    ///
+    /// A JobQueue will only push a job once `fence` has been signaled.
+    pub fn add_dependency(&mut self, fence: &Fence) -> Result {
+        self.inner.as_mut().with_project(|job| {
+            // If the registration below gets registered successfully, a signaling
+            // fence will decrement the atomic. That could race. Thus, increment in
+            // advance. Ordering is ensured thanks to the dma_fence backend.
+            job.nr_of_deps.fetch_add(1, Relaxed);
+
+            let dependency = try_pin_init!(Dependency {
+                links <- ListLinks::new(),
+                // SAFETY: The `registration` is not forgotten. It drops with JobQueue.
+                registration <- unsafe {
+                    FenceCallbackRegistration::new(
+                        fence,
+                        DependencyWaker {
+                            nr_of_deps: job.nr_of_deps,
+                            jq: job.jq,
+                        },
+                    )
+                }
+            });
+            match UniqueArc::pin_init(dependency, GFP_KERNEL) {
+                Err(e) => {
+                    let _ = job.nr_of_deps.fetch_sub(1, Relaxed);
+                    if e == ENOENT {
+                        // Was already signaled. No reason to bother the caller.
+                        return Ok(());
+                    }
+                    return Err(e);
+                }
+                Ok(dep) => {
+                    job.dependencies.push_back(dep);
+                }
+            }
+
+            Ok(())
+        })
+    }
+
+    /// Submit the job.
+    ///
+    /// Returns a [`dma_buf::Fence`] on which the user can register callbacks.
+    /// The fence will be signaled once the job is completed through
+    /// [`JobQueue::complete_jobs_up_to_seqno`], which can happen immediately
+    /// after the job has been submitted.
+    ///
+    /// This function does all fence initialization under the JobQueue lock in
+    /// one go, including setting of the fence sequence number. Thus, it is
+    /// typically unnecessary (and advaised against) to call this function with
+    /// a driver lock held.
+    pub fn submit(self) -> ARef<Fence> {
+        let jq = self.inner.jq;
+        jq.with_inner(|inner| {
+            // SAFETY: this is a lifetime transmute from `Job<'queue, T>` to
+            // `Job<'fctx, T>`.
+            //
+            // `job` internally holds a reference to `JobQueue`, while we are
+            // now moving `job` into `inner`, which may borrow from `fctx` but
+            // not the full `JobQueue`. So on surface this would be incorrect.
+            // However, as we drain `inner` inside `JobQueue::drop`, the
+            // reference is gone before any field is destructed.
+            let mut job = unsafe { core::mem::transmute::<Job<'_, T>, Job<'_, T>>(self) };
+
+            // The lock orders setting of the sequence number, so no driver lock is needed.
+            let mut inner = inner.lock();
+            let fence = job.fence_allocation.new_fence();
+            let ret_fence = ARef::from(fence.as_fence());
+
+            *job.inner.as_mut().project().fence = Some(fence);
+
+            inner.waiting_jobs.push_back(job.inner);
+            drop(inner);
+            jq.check_start_submit_worker();
+
+            ret_fence
+        })
+    }
+}
+
+#[pin_data]
+struct Dependency<'b, 'nr_of_deps, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    links: ListLinks,
+    #[pin]
+    registration: FenceCallbackRegistration<DependencyWaker<'b, 'nr_of_deps, T>>,
+}
+
+impl_list_arc_safe! {
+    impl{'b, T: JobQueueOps + Send + Sync} ListArcSafe<0> for Dependency<'b, '_, T> { untracked; }
+}
+impl_list_item! {
+    impl{'b, T: JobQueueOps + Send + Sync} ListItem<0> for Dependency<'b, '_, T> {
+        using ListLinks { self.links }; }
+}
+
+#[pin_data]
+#[repr(C)]
+struct JobInternal<'b, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    links: ListLinks,
+    cost: u32,
+    fence: Option<DriverFence<'b, DriverDataWrapper<T>>>,
+    dependencies: UniqueList<Dependency<'b, 'nr_of_deps, T>>,
+    nr_of_deps: Atomic<u32>,
+    jq: &'b JobQueue<T>,
+}
+
+impl_list_arc_safe! {
+    impl{'b, T: JobQueueOps + Send + Sync} ListArcSafe<0> for JobInternal<'b, T> { untracked; }
+}
+impl_list_item! {
+    impl{'b, T: JobQueueOps + Send + Sync} ListItem<0> for JobInternal<'b, T> {
+        using ListLinks { self.links }; }
+}
+
+struct SubmitWorker<'a, 'fctx, T: JobQueueOps + Send + Sync> {
+    srcu: &'a Srcu,
+    revoked: &'a AtomicFlag,
+    inner: &'a SpinLockIrq<JobQueueInner<'fctx, T>>,
+    fctx: &'fctx FenceContext<DriverDataWrapper<T>>,
+}
+
+impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for SubmitWorker<'_, '_, T> {
+    fn run(work: &ScopedWorkRef<Self>) {
+        // Synchronize against revocation in `JobQueue::drop`.
+        let _lock_guard = work.srcu.read_lock();
+        if work.revoked.load(Relaxed) {
+            return;
+        }
+
+        let mut jq = work.inner.lock();
+
+        while let Some(job) = jq.as_mut().project().waiting_jobs.pop_front() {
+            // While we didn't hold the lock below for `run_job()`, it could be
+            // that a new job entered the waiting list which has an unfulfilled
+            // dependency.
+            if job.nr_of_deps.load(Relaxed) > 0 {
+                jq.waiting_jobs.push_front(job);
+                break;
+            }
+            let new_capacity = jq.capacity as i64 - i64::from(job.cost);
+            if new_capacity < 0 {
+                jq.waiting_jobs.push_front(job);
+                break;
+            }
+            *jq.as_mut().project().capacity = new_capacity as u64;
+
+            let fence = job.fence.as_ref().expect("fence not present");
+            let seqno = fence.as_fence().seqno();
+            let runnable_job = JobRunnable {
+                seqno,
+                data: fence.deref(),
+            };
+
+            drop(jq); // Release lock.
+            T::run_job(work.fctx, runnable_job);
+            jq = work.inner.lock(); // Retake lock.
+
+            // run_job() above needs to be called without lock protection. Thus,
+            // it is possible that the driver instructed completion right before
+            // we could re-take the lock.
+            if jq.last_completed >= seqno {
+                fence.signal(Ok(()));
+
+                // Drop here directly if possible. Otherwise, let the DropWorker
+                // take care of it.
+                if core::mem::needs_drop::<T::JobDataType>() {
+                    jq.drop_list.push_back(job);
+                }
+            } else {
+                jq.running_jobs.push_back(job);
+            }
+        }
+    }
+}
+
+struct DropWorker<'a, 'fctx, T: JobQueueOps + Send + Sync> {
+    srcu: &'a Srcu,
+    revoked: &'a AtomicFlag,
+    inner: &'a SpinLockIrq<JobQueueInner<'fctx, T>>,
+}
+
+impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, '_, T> {
+    fn run(work: &ScopedWorkRef<Self>) {
+        // Synchronize against revocation in `JobQueue::drop`.
+        let _lock_guard = work.srcu.read_lock();
+        if work.revoked.load(Relaxed) {
+            return;
+        }
+
+        let mut jq_locked = work.inner.lock();
+
+        while let Some(job) = jq_locked.drop_list.pop_front() {
+            drop(jq_locked);
+            drop(job);
+            jq_locked = work.inner.lock();
+        }
+    }
+}
+
+#[pin_data]
+struct JobQueueInner<'a, T: JobQueueOps + Send + Sync> {
+    /// Fence sequence number of the last job the user has completed.
+    #[pin]
+    /// List of jobs waiting to be run on the hardware.
+    waiting_jobs: UniqueList<JobInternal<'a, T>>,
+    #[pin]
+    /// Jobs that are currently executing on the hardware.
+    running_jobs: UniqueList<JobInternal<'a, T>>,
+    /// The queue's capacity.
+    capacity: u64,
+    /// The sequence number of the last completed job.
+    last_completed: u64,
+    #[pin]
+    /// Jobs that have finished executing and whose payload data `T` implements
+    /// `Drop`. These jobs are dropped in process context, which also allows for
+    /// their [`dma_buf::DriverFence`]s to implement the necessary RCU grace
+    /// period delay.
+    ///
+    /// If `Drop` is not implemented, this list is unused and the elements drop
+    /// directly in [`JobQueue::complete_jobs_up_to_seqno`].
+    ///
+    /// Should the JobQueue drop and the [`DropWorker`] not yet have dropped all
+    /// jobs, that is no problem because the JobQueue itself drops in process
+    /// context.
+    drop_list: UniqueList<JobInternal<'a, T>>,
+}
+
+/// A JobQueue.
+///
+/// When you drop your JobQueue, it might still attempt for one RCU grace period
+/// to submit more jobs via the [`JobQueueOps::run_job`] callback into your driver.
+///
+/// Dropping a JobQueue results in all remaining waiting and running jobs'
+/// fences being signaled with ECANCELED.
+///
+/// A JobQueue must only ever drop in non-atomic / process context.
+///
+/// # Examples
+///
+/// ```
+/// use core::ops::Deref;
+///
+/// use kernel::{
+///     str::CString,
+///     dma_buf::*,
+///     drm::{
+///         JobQueue,
+///         JobQueueOps,
+///         JobRunnable,
+///     },
+/// };
+///
+/// let driver_name = CString::try_from_fmt(fmt!("dummy_driver"))?;
+/// let timeline_name = CString::try_from_fmt(fmt!("dummy_timeline"))?;
+///
+/// #[pin_data]
+/// struct FenceContextData {}
+///
+/// impl FenceContextData {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {})
+///     }
+/// }
+///
+/// impl FenceContextOps for FenceContextData {
+///     type FenceDataType = ();
+/// }
+///
+/// let fctx_data = FenceContextData::new();
+///
+/// let fctx = KBox::pin_init(
+///     FenceContext::new(0, c"dependency_driver", c"dependency_timeline", fctx_data),
+///     GFP_KERNEL
+/// )?;
+///
+/// let dependency1 = fctx.new_fence_allocation(())?.new_fence();
+/// let dependency2 = fctx.new_fence_allocation(())?.new_fence();
+///
+/// #[pin_data]
+/// struct JqData {}
+///
+/// impl JqData {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {})
+///     }
+/// }
+///
+/// struct Payload { }
+///
+/// impl JobQueueOps for JqData {
+///     type JobDataType = Payload;
+///
+///     fn run_job<'a>(&self, job: JobRunnable<'a, Payload>) {
+///         pr_info!("Job Nr. {} gets run now.\n", job.seqno);
+///     }
+///
+///     fn kill(&self, jq_nr: u64, err: Error) {
+///         pr_err!("The JQ Nr. {} became blocked forever because deps are blocked with err: {}\n",
+///                 jq_nr, err);
+///     }
+/// }
+///
+/// let jq_data = JqData::new();
+/// let jq = KBox::pin_init(
+///     JobQueue::new(0, driver_name, timeline_name, 1000, jq_data),
+///     GFP_KERNEL
+/// )?;
+///
+///
+/// let mut job1 = jq.new_job(1, Payload { })?;
+/// let mut job2 = jq.new_job(1, Payload { })?;
+///
+/// job1.add_dependency(dependency1.as_fence())?;
+/// job1.add_dependency(dependency1.as_fence())?;
+///
+/// job2.add_dependency(dependency2.as_fence())?;
+///
+/// struct Callback {
+///     seqno: u64,
+/// }
+///
+/// impl FenceCallback for Callback {
+///     fn on_signal(&mut self, res: Result) {
+///         pr_info!("Job Nr. {} got completed.\n", self.seqno);
+///     }
+/// }
+///
+/// let fence1 = job1.submit();
+/// let fence2 = job2.submit();
+///
+/// let cb = Callback { seqno: fence2.seqno() };
+/// // SAFETY: The registration is not leaked.
+/// let reg = unsafe { FenceCallbackRegistration::new(&fence2, cb) };
+/// let reg = KBox::new(reg, GFP_KERNEL)?;
+///
+/// dependency1.signal(Ok(()));
+/// dependency2.signal(Ok(()));
+///
+/// Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct JobQueue<T: JobQueueOps + Send + Sync> {
+    #[pin]
+    #[uses('_: invariant, 'revoked: invariant, 'srcu: invariant)]
+    drop_worker: ScopedWork<DropWorker<'inner, 'fctx, T>>,
+    #[pin]
+    #[uses('_: invariant)]
+    submit_worker: ScopedWork<SubmitWorker<'inner, 'fctx, T>>,
+    #[pin]
+    #[uses('fctx: invariant)]
+    inner: SpinLockIrq<JobQueueInner<'fctx, T>>,
+    #[pin]
+    fctx: FenceContext<DriverDataWrapper<T>>,
+    revoked: AtomicFlag,
+    #[pin]
+    srcu: Srcu,
+}
+
+// SAFETY: The JobQueue is locked and pinned.
+unsafe impl<T: JobQueueOps + Send + Sync> Sync for JobQueue<T> {}
+// SAFETY: The JobQueue is locked and pinned.
+unsafe impl<T: JobQueueOps + Send + Sync> Send for JobQueue<T> {}
+
+/// Object passed to the driver to run a job.
+pub struct JobRunnable<'a, T> {
+    /// The job's sequence number.
+    pub seqno: u64,
+    /// The associated job data.
+    pub data: &'a T,
+}
+
+/// Ops for the JobQueue.
+pub trait JobQueueOps {
+    /// The type of the data passed over in [`JobQueue::new_job`].
+    type JobDataType: Send + Sync;
+
+    /// Instructs the driver to run this job.
+    ///
+    /// JobQueue calls this callback from process context without any locks
+    /// held, thus, the driver is permitted to sleep in its implementation.
+    ///
+    /// The driver must be aware that JobQueue trusts on its credit count system
+    /// for this operation to be infallible.
+    ///
+    /// This callback might be called while the driver is in the process of
+    /// dropping the JobQueue, but will never be called afterwards.
+    fn run_job<'a>(&self, job: JobRunnable<'a, Self::JobDataType>);
+
+    /// Tells the driver to tear this JobQueue down.
+    ///
+    /// The JobQueue backend invokes this in case a job's dependency got
+    /// signaled with an error. This means that the dependency's associated
+    /// action on a GPU ring have failed and will not be recovered.
+    ///
+    /// Thus, it is necessary to tear this JobQueue down, too. Upon receiving this
+    /// ops, the driver should stop submitting to this JobQueue and then call
+    /// [`JobQueue::teardown`] from a different context.
+    ///
+    /// This ops is invoked in atomic context.
+    fn kill(&self, jq_number: u64, err: Error);
+}
+
+#[pin_data]
+struct DriverDataWrapper<T: JobQueueOps + Send + Sync> {
+    #[pin]
+    data: T,
+}
+
+impl<T: JobQueueOps + Send + Sync> Deref for DriverDataWrapper<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.data
+    }
+}
+
+impl<T: JobQueueOps + Send + Sync> DriverDataWrapper<T> {
+    fn new<E>(data: impl PinInit<T, E>) -> impl PinInit<Self, E>
+    where
+        Error: From<E>,
+        E: From<Infallible>,
+    {
+        try_pin_init!(Self {
+            data <- data,
+        }? E)
+    }
+}
+
+impl<T: JobQueueOps + Send + Sync> FenceContextOps for DriverDataWrapper<T> {
+    type FenceDataType = T::JobDataType;
+}
+
+impl<T: JobQueueOps + Send + Sync> Deref for JobQueue<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.fctx.deref()
+    }
+}
+impl<T: JobQueueOps + Send + Sync> JobQueue<T> {
+    /// Create a new JobQueue.
+    pub fn new<E>(
+        initial_seqno: u64,
+        // TODO: pass these as &CStr. Figure out how to get the lifetimes for PinInit right.
+        driver_name: CString,
+        timeline_name: CString,
+        capacity: u64,
+        data: impl PinInit<T, E>,
+    ) -> impl PinInit<Self, Error>
+    where
+        Error: From<E>,
+        E: From<Infallible>,
+    {
+        try_pin_init!(Self {
+            srcu <- new_srcu!(),
+            revoked: AtomicFlag::new(false),
+            fctx <- FenceContext::new(initial_seqno, &driver_name, &timeline_name,
+                                      DriverDataWrapper::new(data)),
+            inner <- new_spinlock_irq!(try_pin_init!(JobQueueInner {
+                capacity,
+                last_completed: 0,
+                waiting_jobs: UniqueList::new(),
+                running_jobs: UniqueList::new(),
+                drop_list: UniqueList::new(),
+            })),
+            submit_worker <- new_scoped_work!("JobQueueSubmitWorker", Ok(SubmitWorker {
+                srcu: Pin::get_ref(srcu),
+                revoked,
+                inner: Pin::get_ref(inner),
+                fctx: Pin::get_ref(fctx)
+            })),
+            drop_worker <- new_scoped_work!("JobQueueDropWorker", Ok(DropWorker {
+                srcu: Pin::get_ref(srcu),
+                revoked,
+                inner: Pin::get_ref(inner)
+            })),
+        })
+    }
+
+    /// Give the uniqe identifier for this JobQueue.
+    ///
+    /// This corresponds to the JobQueue's underlying [`dma_buf::FenceContext`].
+    pub fn id(&self) -> u64 {
+        self.fctx.id()
+    }
+
+    /// Create a new job.
+    ///
+    /// The `cost` specified here is what JobQueue subtracts from its capacity
+    /// to determine whether a job is runnable, i.e., has space on the GPU ring.
+    ///
+    /// The `data` contained by a job will be borrowed back to the driver once
+    /// the jobs shall be run through [`JobQueueOps::run_job`].
+    pub fn new_job<'a>(&'a self, cost: u32, data: T::JobDataType) -> Result<Job<'a, T>> {
+        let fence_allocation = self.fctx.new_fence_allocation(data)?;
+        let job = try_pin_init!(JobInternal {
+            links <- ListLinks::new(),
+            cost,
+            fence: None,
+            nr_of_deps: Atomic::new(0),
+            dependencies: UniqueList::new(),
+            jq: &self,
+        });
+
+        let inner = UniqueArc::pin_init(job, GFP_KERNEL)?;
+
+        Ok(Job {
+            inner,
+            fence_allocation,
+        })
+    }
+
+    fn check_start_submit_worker(&self) {
+        self.with_submit_worker(|submit_worker| {
+            // TODO this shouldn't be the system wq
+            // SAFETY: The worker is carried by the JobQueue and, thus, cannot be
+            // forgotten.
+            let _ = unsafe { workqueue::system_dfl().enqueue_scoped(submit_worker) };
+        })
+    }
+
+    fn check_start_drop_worker(&self) {
+        self.with_drop_worker(|drop_worker| {
+            // TODO this shouldn't be the system wq
+            // SAFETY: The worker is carried by the JobQueue and, thus, cannot be
+            // forgotten.
+            let _ = unsafe { workqueue::system_dfl().enqueue_scoped(drop_worker) };
+        })
+    }
+
+    /// Complete all the jobs in the queue's running_list, up to `seqno`.
+    ///
+    /// This signals the jobs' fences and schedules dropping of both the [`Job`]
+    /// and its [`DriverFence`].
+    ///
+    /// This signals the associated fences with the `Ok(())` status.
+    ///
+    /// This function tells the implementation that there is now more capacity
+    /// for more jobs to be pushed into the GPU ring.
+    pub fn complete_jobs_up_to_seqno(&self, seqno: u64) {
+        self.with_inner(|inner| {
+            let needs_drop = core::mem::needs_drop::<T::JobDataType>();
+            let mut jq_locked = inner.lock();
+            let mut jq = jq_locked.as_mut().project();
+
+            if seqno < *jq.last_completed {
+                return;
+            }
+
+            while let Some(mut job) = jq.running_jobs.pop_front() {
+                if job
+                    .as_mut()
+                    .project()
+                    .fence
+                    .as_mut()
+                    .expect("fence not present")
+                    .as_fence()
+                    .seqno()
+                    > seqno
+                {
+                    jq.running_jobs.push_front(job);
+                    break;
+                }
+
+                *jq.capacity += u64::from(job.cost);
+
+                let fence = job.fence.as_ref().expect("fence not present");
+                fence.signal(Ok(()));
+
+                if needs_drop {
+                    jq.drop_list.push_back(job);
+                }
+                // Otherwise, job is dropped here directly. Its fence won't perform
+                // an RCU grace period wait.
+            }
+
+            // This enables the SubmitWorker to complete a job that is not yet
+            // in 'running_jobs', in case of a race against the lock.
+            *jq.last_completed = seqno;
+            drop(jq_locked);
+
+            self.check_start_submit_worker();
+            if needs_drop {
+                self.check_start_drop_worker();
+            }
+        })
+    }
+
+    /// Tear the JobQueue down. Complete all pending jobs and signal their
+    /// fences with `error`.
+    ///
+    /// Only use this if you want to tear the JobQueue down in an error path and
+    /// want to specify the error.
+    ///
+    /// You can also just drop the JobQueue, which would result in all remaining
+    /// jobs' fences being signaled with ECANCELED.
+    ///
+    /// Note that this function has a small race window against the
+    /// `SubmitWorker` and its [`JobQueueOps::run_job`] callback, where the
+    /// latter might theoretically succeed at pushing more jobs to the driver.
+    /// The driver likely will want to ignore such attempts to push more jobs to
+    /// the GPU ring. Besides, the race merely results in these subsequent
+    /// jobs being signaled with ECANCELED on drop, thus, maybe differing from
+    /// the `error` provided here.
+    ///
+    /// This function must be called from non-atomic context.
+    pub fn teardown<E>(self, error: Error)
+    where
+        Error: From<E>,
+    {
+        self.with_inner(|inner| {
+            let mut jq = inner.lock();
+
+            // We don't drop the jobs and fences here while we hold the lock. Just
+            // signal with the error. The dropping lists will then drop them locklessly.
+
+            while let Some(job) = jq.running_jobs.pop_front() {
+                let fence = job.fence.as_ref().expect("fence not present");
+                fence.signal(Err(error));
+
+                jq.drop_list.push_back(job);
+            }
+        })
+    }
+}
+
+#[pinned_drop]
+impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Revoke to prevent still existing DependencyWakers from kicking the
+        // SubmitWorker again before we could deregister them.
+        self.revoked.store(true, Relaxed);
+        self.srcu.synchronize();
+        self.with_inner(|inner| {
+            let mut inner = inner.lock();
+            let waiting_jobs = core::mem::take(&mut inner.waiting_jobs);
+            let running_jobs = core::mem::take(&mut inner.running_jobs);
+            let drop_list = core::mem::take(&mut inner.drop_list);
+            drop(inner);
+            drop(waiting_jobs);
+            drop(running_jobs);
+            drop(drop_list);
+        })
+    }
+}
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index fd6ed35bc35a..f2b7fbbce5bb 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -8,6 +8,7 @@
 pub mod gem;
 pub mod gpuvm;
 pub mod ioctl;
+pub mod job_queue;
 
 pub use self::device::Device;
 pub use self::device::DeviceContext;
@@ -20,6 +21,9 @@
 pub use self::driver::DriverInfo;
 pub use self::driver::Registration;
 pub use self::file::File;
+pub use self::job_queue::JobQueue;
+pub use self::job_queue::JobQueueOps;
+pub use self::job_queue::JobRunnable;
 
 pub(crate) mod private {
     pub trait Sealed {}
-- 
2.56.0

