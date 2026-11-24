Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E04606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Illbisei
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75E310F558;
	Tue, 24 Nov 2026 12:31:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E479E10F552
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:31:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA78545723;
 Tue, 24 Nov 2026 12:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A11F000D2;
 Tue, 24 Nov 2026 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523481;
 bh=pe2GBAzYHXSU6bQ07dRQhbuFobyLBalHMu7os0GzqT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IllbiseivlmXxJYKEBv1kR/XI0vI+ju9+VJ3c7Vn4zZ05ud8eHXiUfeg2FzFuW8Ln
 wtQlVWLINZuVsIzbnxpEI5nSSuN5NrcxBqYJ//HeHhhxqmlK3ov9T3otJ2AoQHVNFp
 8k2gR+ITf5bGY4yFli76LvYck/ktFNEVZ9BscHz0+NbqXbtOSyiNXSew2/RNa6W3g0
 +uHmAK/Zn+9n577DqnPT3Q7draFixPyAGR4o6/xfbqQusyQTkKdkNCryvmjQy+nhj0
 7dRGROUW+1KzKzP/K+PJPgmiVIt0bW+at2GfBRqDkIN0aSo4U1nxJwPTgQe6eB9Uzt
 3xVqRvjz/RPmw==
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
Subject: [PATCH v2 09/10] rust: drm: Add JobQueue
Date: Tue, 24 Nov 2026 13:29:51 +0100
Message-ID: <20261124122951.878199-11-phasta@kernel.org>
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

JobQueue is a pure Rust component that handles job submissions for GPUs
with firmware scheduling, i.e., GPUs that support one exclusive ring per
execution context.

JobQueue's primary task is dependency handling, where the user can set
dependencies, each in the form of a `dma_buf::Fence`, on a job and then
submit it to the queue.

Jobs are being executed in FIFO order. Only jobs whose dependencies are
all fulfilled get executed, otherwise the JobQueue pauses.

A core design principle, just like with DmaFence, is to avoid all
allocations in job submission paths, since this runs danger of
deadlocking. For the same reason JobQueue's run_job workqueue is
reclaim-safe.

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

Like drm_sched, JobQueue currently does not take errors set on job
dependency fences into account. The reasons are that only all
dependencies being signaled is decisive for memory safety, and that we
would first have to establish what the semantic meaning of fence errors
actually is. That's especially difficult when you consider that fences
can be shared across drivers. Nevertheless, it would be doable to inform
drivers through their run_job callback that this particular jobs has
failed (but signaled) dependencies, and then allow the driver to make a
decision on how to proceed (i.e., ignore or kill JQ).

When a job shall be run, both its JobQueue::data and Job::data get
borrowed back to the driver, together with the sequence number of this
job, so that it can perform the appropriate interaction with the
hardware.

The RunWorker runs all ready jobs based on a credit count system, so
that run_job() is infallible. A separate worker drops jobs (and
their fences) that are already completed, but only if the user's payload
data actually requires Drop. Otherwise, jobs are dropped by the
RunWorker directly.

Data left over by the workers drops together with JobQueue. For this
reason, and because a JobQueue owns a FenceContext, it must only ever
be dropped in process context.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Co-developed-by: Gary Guo <gary@garyguo.net>

(^ waiting for Gary to sign-off)
---
 rust/kernel/drm/job_queue.rs | 863 +++++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs       |   4 +
 2 files changed, 867 insertions(+)
 create mode 100644 rust/kernel/drm/job_queue.rs

diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
new file mode 100644
index 000000000000..3d3d78fda551
--- /dev/null
+++ b/rust/kernel/drm/job_queue.rs
@@ -0,0 +1,863 @@
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
+//! and prepare all memory allocations. A later job submission through
+//! [`Job::submit()`] sets up the fence and performs no fallible operations.
+//!
+//! Before jobs are submitted to a queue, dependencies in the form of
+//! [`dma_buf::Fence`] can be set on them. Jobs are run by the JobQueue in
+//! process context through a work item in FIFO order. Only jobs whose
+//! dependency fences have all been signaled are run. If the front job's
+//! dependency is not yet fulfilled, the JobQueue pauses until that's the case.
+//!
+//! If a dependency fence gets signaled with an error, JobQueue currently runs
+//! it nevertheless, like drm_sched does, since drivers do not seem to desire
+//! their queues to be killed in such cases.
+//!
+//! JobQueue implements a credit count system, where the queue itself gets
+//! assigned a capacity by the user, and jobs get assigned individual cost. Jobs
+//! are only run if there is enough capacity; if not, running stops until that
+//! is the case. These credits must accurately represent the capacity on the GPU
+//! ring the queue was created for.
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
+//! permitted to perform sleeping operations in the callback - except for
+//! sleeping allocations, of course, since this is the fence signaling path.
+//! JobQueue handles races between `run_job` and
+//! [`JobQueue::complete_jobs_up_to_seqno()`].
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
+        },
+        new_spinlock_irq,
+        SpinLockIrq, //
+    }, //
+    sync::{
+        atomic::AtomicFlag,
+        Srcu, //
+    },
+    sync::{Arc, UniqueArc},
+    workqueue::{
+        new_scoped_work,
+        OwnedQueue,
+        Queue,
+        ScopedWork,
+        ScopedWorkItem, //
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
+    fn on_signal(&mut self, _res: Result) {
+        // Last dependency kicks the worker. This cannot cause UAF on JQ if the
+        // associated job was forgotten because only submitted jobs can reach 0.
+        if self.nr_of_deps.fetch_sub(1, Relaxed) == 1 {
+            // The drop-order of JobQueue ensures that all DependencyWakers are
+            // cancelled before the JobQueue itself is dropped.
+            self.jq.check_start_run_worker();
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
+    /// A JobQueue will only run a job once `fence` has been signaled.
+    ///
+    /// This action can race with the fence being signaled. An already signaled
+    /// dependency fence is treated as success, even if the fence was signaled
+    /// with an error. JobQueue will nevertheless try to run the job in the
+    /// latter case.
+    pub fn add_dependency(&mut self, fence: &Fence) -> Result {
+        self.inner.as_mut().with_project(|job| {
+            // If the registration below gets registered successfully, a signaling
+            // fence will decrement the atomic. That could race. Thus, increment in
+            // advance. Ordering is ensured thanks to the dma_fence backend.
+            job.nr_of_deps.fetch_add(1, Relaxed);
+
+            let dependency = try_pin_init!(Dependency {
+                links <- ListLinks::new(),
+                // SAFETY:
+                // We do not satisfy the *precise* safety requirement of not
+                // leaking the registration - because the job (`self`) could
+                // indeed leak.
+                //
+                // However, it is still safe because the registration lives as
+                // long as the job, whose atomic nr_of_deps can only reach 0
+                // after the job was submitted, thus, preventing UAF on the
+                // JobQueue.
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
+                        // Was already signaled.
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
+    /// typically unnecessary (and advised against) to call this function with
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
+            // Job is submitted now. Signaling dependencies are now allowed to
+            // kick the worker.
+            let _ = job.inner.nr_of_deps.fetch_sub(1, Relaxed);
+
+            inner.waiting_jobs.push_back(job.inner);
+            drop(inner);
+            jq.check_start_run_worker();
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
+struct RunWorker<'a, 'fctx, T: JobQueueOps + Send + Sync> {
+    srcu: &'a Srcu,
+    parked: &'a AtomicFlag,
+    inner: &'a SpinLockIrq<JobQueueInner<'fctx, T>>,
+    fctx: &'fctx FenceContext<DriverDataWrapper<T>>,
+}
+
+impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for RunWorker<'_, '_, T> {
+    fn run(work: &ScopedWork<Self>) {
+        // Synchronize against revocation in `JobQueue::drop`.
+        let _lock_guard = work.srcu.read_lock();
+        if work.parked.load(Relaxed) {
+            return;
+        }
+
+        let mut jq = work.inner.lock();
+
+        while let Some(job) = jq.waiting_jobs.pop_front() {
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
+                *jq.as_mut().project().capacity += u64::from(job.cost);
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
+    inner: &'a SpinLockIrq<JobQueueInner<'fctx, T>>,
+}
+
+impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, '_, T> {
+    fn run(work: &ScopedWork<Self>) {
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
+    #[pin]
+    /// List of jobs waiting to be run on the hardware.
+    waiting_jobs: UniqueList<JobInternal<'a, T>>,
+    #[pin]
+    /// List of jobs that are currently executing on the hardware.
+    running_jobs: UniqueList<JobInternal<'a, T>>,
+    /// The queue's current capacity.
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
+/// Dropping a JobQueue results in all remaining waiting jobs'
+/// fences being signaled with ECANCELED. All remaining running jobs' fences get
+/// signaled with the error you provided in [`JobQueue::set_error()`], or
+/// ECANCELED otherwise.
+///
+/// A JobQueue must only ever drop in non-atomic / process context.
+///
+/// # Examples
+///
+/// ```
+/// use core::ops::Deref;
+///
+/// use kernel::{
+///     dma_buf::*,
+///     drm::{
+///         JobQueue,
+///         JobQueueOps,
+///         JobRunnable, //
+///     },
+///     str::CString,
+///     time::{
+///         delay::fsleep,
+///         Delta, //
+///     }, //
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
+/// }
+///
+/// let jq_data = JqData::new();
+/// let jq = KBox::pin_init(
+///     JobQueue::new(driver_name, timeline_name, 1000, jq_data),
+///     GFP_KERNEL
+/// )?;
+///
+///
+/// let mut job1 = jq.new_job(1, Payload { })?;
+/// let mut job2 = jq.new_job(1, Payload { })?;
+///
+/// job1.add_dependency(dependency1.as_fence())?;
+/// job1.add_dependency(dependency2.as_fence())?;
+///
+/// job2.add_dependency(dependency2.as_fence())?;
+///
+/// struct Callback {
+///     seqno: u64,
+/// }
+///
+/// impl FenceCallback for Callback {
+///     fn on_signal(&mut self, res: Result) {
+///         pr_info!("Job Nr. {} got completed with status: {:?}.\n", self.seqno, res);
+///     }
+/// }
+///
+/// let done_fence1 = job1.submit();
+/// let done_fence2 = job2.submit();
+///
+/// let cb = Callback { seqno: done_fence2.seqno() };
+/// // SAFETY: The registration is not leaked.
+/// let reg = unsafe { FenceCallbackRegistration::new(&done_fence2, cb) };
+/// let reg = KBox::new(reg, GFP_KERNEL)?;
+///
+/// dependency1.signal(Ok(()));
+/// dependency2.signal(Ok(()));
+///
+/// // Give the RunWorker some time to run the jobs.
+/// fsleep(Delta::from_millis(100));
+/// jq.complete_jobs_up_to_seqno(done_fence2.seqno());
+///
+/// match done_fence2.status() {
+///     FenceStatus::Signaled(status) => return status,
+///     FenceStatus::Unsignaled => return Err(EAGAIN),
+/// }
+///
+/// Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct JobQueue<T: JobQueueOps + Send + Sync> {
+    /// The queue's maximum available capacity.
+    max_capacity: u64,
+    /// The work queue on which the JobQueue drops the user's payload data.
+    drop_queue: OwnedQueue,
+    #[pin]
+    #[uses('_: invariant, 'parked: invariant, 'srcu: invariant)]
+    /// A worker for dropping the queue's jobs.
+    drop_worker: ScopedWork<DropWorker<'inner, 'fctx, T>>,
+    /// The work queue on which the JobQueue runs jobs ([`JobQueueOps::run_job`]).
+    run_queue: OwnedQueue,
+    #[pin]
+    #[uses('_: invariant)]
+    /// The worker submitting the queue's ready jobs.
+    run_worker: ScopedWork<RunWorker<'inner, 'fctx, T>>,
+    #[pin]
+    #[uses('fctx: invariant)]
+    /// The inner queue.
+    inner: SpinLockIrq<JobQueueInner<'fctx, T>>,
+    #[pin]
+    /// The [`dma_buf::FenceContext`] on which the queue creates
+    /// [`dma_buf::DriverFence`]s for the jobs.
+    fctx: FenceContext<DriverDataWrapper<T>>,
+    /// Needed for the park() and unpark() features.
+    parked: AtomicFlag,
+    #[pin]
+    /// Needed for the `parked` mechanism, since [`JobQueueOps::run_job`] might
+    /// sleep.
+    srcu: Srcu,
+    /// The error with which the JobQueue will signal still running jobs when it
+    /// drops.
+    err: Error,
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
+    // TODO: Pass the driver the failed dependency fences or their error codes here.
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
+    /// However, `run_job()` is, of course, in the dma_fence critical path,
+    /// which is why you must not perform sleeping allocations here.
+    ///
+    /// The driver must be aware that JobQueue trusts on its credit count system
+    /// for this operation to be infallible.
+    ///
+    /// This callback might be called while the driver is in the process of
+    /// dropping the JobQueue, but will never be called afterwards.
+    fn run_job<'a>(&self, job: JobRunnable<'a, Self::JobDataType>);
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
+        self.fctx.deref()
+    }
+}
+
+impl<T: JobQueueOps + Send + Sync> JobQueue<T> {
+    /// Create a new JobQueue.
+    pub fn new<E>(
+        // TODO: pass these as &CStr. Figure out how to get the lifetimes for PinInit right.
+        driver_name: CString,
+        timeline_name: CString,
+        capacity_param: u64,
+        data: impl PinInit<T, E>,
+    ) -> impl PinInit<Self, Error>
+    where
+        Error: From<E>,
+        E: From<Infallible>,
+    {
+        try_pin_init!(Self {
+            srcu <- new_srcu!(),
+            parked: AtomicFlag::new(false),
+            max_capacity: capacity_param,
+            err: ECANCELED,
+            // The initial sequence number always starts at 1, since hardware is
+            // initialized to 0. Also makes internal logic easier.
+            fctx <- FenceContext::new(1, &driver_name, &timeline_name,
+                                      DriverDataWrapper::new(data)),
+            inner <- new_spinlock_irq!(try_pin_init!(JobQueueInner {
+                capacity: capacity_param,
+                last_completed: 0,
+                waiting_jobs: UniqueList::new(),
+                running_jobs: UniqueList::new(),
+                drop_list: UniqueList::new(),
+            })),
+            run_queue: Queue::new_unbound().mem_reclaim().build(c"JobQueueRunQueue")?,
+            // SAFETY: The worker does not get leaked. It drops together with JobQueue.
+            run_worker <- unsafe { new_scoped_work!("JobQueueRunWorker", Ok(RunWorker {
+                srcu: Pin::get_ref(srcu),
+                parked,
+                inner: Pin::get_ref(inner),
+                fctx: Pin::get_ref(fctx),
+            })) },
+            drop_queue: Queue::new_unbound().build(c"JobQueueDropQueue")?,
+            // SAFETY: The worker does not get leaked. It drops together with JobQueue.
+            drop_worker <- unsafe { new_scoped_work!("JobQueueDropWorker", Ok(DropWorker {
+                inner: Pin::get_ref(inner)
+            })) },
+        })
+    }
+
+    /// Give the unique identifier for this JobQueue.
+    ///
+    /// This corresponds to the JobQueue's underlying [`dma_buf::FenceContext`].
+    /// It is unique for all JobQueues in the entire system.
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
+    /// the job shall be run through [`JobQueueOps::run_job`].
+    pub fn new_job<'a>(&'a self, cost: u32, data: T::JobDataType) -> Result<Job<'a, T>> {
+        if u64::from(cost) > self.max_capacity {
+            return Err(EINVAL);
+        }
+
+        let fence_allocation = self.fctx.new_fence_allocation(data)?;
+        let job = try_pin_init!(JobInternal {
+            links <- ListLinks::new(),
+            cost,
+            fence: None,
+            // Initialize to 1 to prevent UAF for forgotten jobs. See
+            // [`Job::add_dependency()`].
+            nr_of_deps: Atomic::new(1),
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
+    fn check_start_run_worker(&self) {
+        // SAFETY: `self` is valid.
+        let this = unsafe { Pin::new_unchecked(self) };
+        this.with_project_ref(|project| {
+            project
+                .run_queue
+                .enqueue_scoped(Pin::get_ref(project.run_worker));
+        })
+    }
+
+    fn check_start_drop_worker(&self) {
+        // SAFETY: `self` is valid.
+        let this = unsafe { Pin::new_unchecked(self) };
+        this.with_project_ref(|project| {
+            project
+                .drop_queue
+                .enqueue_scoped(Pin::get_ref(project.drop_worker));
+        })
+    }
+
+    /// Prevent the JobQueue from further calling [`JobQueueOps::run_job()`].
+    ///
+    /// The JobQueue will not call [`JobQueueOps::run_job()`] anymore after this
+    /// function returned, until you call [`JobQueue:unpark()`].
+    ///
+    /// Note that you should not use this function unless you have a very good
+    /// reason to.
+    ///
+    /// This must be called in non-atomic context.
+    pub fn park(&self) {
+        self.parked.store(true, Relaxed);
+        self.srcu.synchronize();
+    }
+
+    /// Unpark the JobQueue again.
+    ///
+    /// Note that you should not use this function unless you have a very good
+    /// reason to.
+    ///
+    /// This is the counterpart to [`JobQueue::park()`].
+    pub fn unpark(&self) {
+        self.parked.store(false, Relaxed);
+        // The workqueue barriers ensure ordering.
+        self.check_start_run_worker();
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
+    /// for more jobs to be run.
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
+            // This enables the RunWorker to complete a job that is not yet
+            // in 'running_jobs', in case of a race against the lock.
+            *jq.last_completed = seqno;
+            drop(jq_locked);
+
+            self.check_start_run_worker();
+            if needs_drop {
+                self.check_start_drop_worker();
+            }
+        })
+    }
+
+    /// Set the error with which this JobQueue will signal all running jobs'
+    /// fences. (The jobs on the waiting_list will all complete with ECANCELED
+    /// as their error)
+    pub fn set_error(mut self: Pin<&mut Self>, error: Error) {
+        *self.as_mut().project().err = error;
+    }
+}
+
+#[pinned_drop]
+impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Prevent the RunWorker from moving more jobs to `running_jobs`.
+        self.parked.store(true, Relaxed);
+        self.srcu.synchronize();
+        self.with_inner(|inner| {
+            let mut inner_locked = inner.lock();
+            let drop_list = core::mem::take(&mut inner_locked.drop_list);
+            let waiting_jobs = core::mem::take(&mut inner_locked.waiting_jobs);
+            let mut running_jobs = core::mem::take(&mut inner_locked.running_jobs);
+
+            drop(inner_locked);
+
+            while let Some(job) = running_jobs.pop_front() {
+                let fence = job.fence.as_ref().expect("fence not present");
+                fence.signal(Err(self.err));
+            }
+
+            drop(drop_list);
+            drop(waiting_jobs);
+            drop(running_jobs);
+        })
+    }
+}
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index 7fcf2465a82e..8a29c8d6805f 100644
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

