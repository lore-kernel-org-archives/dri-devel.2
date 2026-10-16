Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF0CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F3E1126BC;
	Fri, 16 Oct 2026 08:58:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5116F1126BC
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:58:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3CE360A8D;
 Fri, 16 Oct 2026 08:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FC91F000C4;
 Fri, 16 Oct 2026 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141087;
 bh=LOfnijBokbdLLVppK6kj9ZLB5y7dKXpoY4WXYsmEPoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ls1K8cwu6PfF14p0OKCT8HWKz5G+St/vOP3lX0fH7pe+lBdF28xoJ0zOWtJfznFe9
 wi0d3I4M9OaEyHjLD1dJUUKfqrgTdFqmooIuFofAy17P+k8T3L7wd6DEUgyjzMRu/Z
 VU1WvOXeu3GizrUQR4I5tkd2ykuCXvUmCTboRgNyDLiOFGymGrIm5X84BoOx8BT+O+
 rvce9VGtIRdF9xyqSo/qS1p/GxEiyJ0YgkNVFsDH49zviCsTYB5AvqJsnWhb81dm2h
 xIgbvTdbsbP+3Klr3barjUTRf52yihCht0QA/w1830FrryyTZElG5CDyzyQPtwHXsW
 cY304wAt5EzPg==
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
Subject: [RFC PATCH v6 5/5] rust: drm: Add JobQueue
Date: Fri, 16 Oct 2026 10:57:24 +0200
Message-ID: <20261016085724.1031766-7-phasta@kernel.org>
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

JobQueue is a pure Rust component that handles job submissions for GPUs
with firmware scheduling, i.e., GPUs that support one exclusive ring per
execution context.

JobQueue's primary task is dependency handling, where the user can set
dependencies, each in the form of a `dma_buf::Fence`, on a job and then
submit it to the queue.

Jobs are being executed in order, following the FIFO principle. Only
jobs whose dependencies are all fullfilled get executed, otherwise the
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
---
 rust/kernel/drm/job_queue.rs | 700 +++++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs       |   4 +
 2 files changed, 704 insertions(+)
 create mode 100644 rust/kernel/drm/job_queue.rs

diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
new file mode 100644
index 000000000000..66f98ee3df70
--- /dev/null
+++ b/rust/kernel/drm/job_queue.rs
@@ -0,0 +1,700 @@
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
+//! dependency is not yet fullfilled, the JobQueue pauses until that's the case.
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
+use crate::prelude::*;
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
+    list::*,
+    revocable::Revocable,
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
+struct DependencyWaker<'b, T: JobQueueOps + Send + Sync> {
+    nr_of_deps: &'b Atomic<u32>,
+    jq: &'b JobQueue<'b, T>,
+}
+
+impl<'b, T: JobQueueOps + Send + Sync> FenceCallback for DependencyWaker<'b, T> {
+    fn on_signal(&mut self) {
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
+    inner: ListArc<JobInternal<'a, T>>,
+}
+
+impl<'a, T: JobQueueOps + Send + Sync> Job<'a, T> {
+    /// Add a dependency for the job.
+    ///
+    /// A JobQueue will only push a job once `fence` has been signaled.
+    pub fn add_dependency(&'a mut self, fence: &Fence) -> Result {
+        let nr_of_deps = &raw const self.inner.nr_of_deps;
+
+        let waker = DependencyWaker {
+            // SAFETY: `nr_of_deps` lives as long as the job.
+            // TODO RFC: Is there a better way to do it? The mutable-immutable references
+            // otherwise run into conflict when `nr_of_deps` is used below.
+            nr_of_deps: unsafe { &*nr_of_deps },
+            jq: self.inner.jq,
+        };
+
+        let job = &mut self.inner;
+
+        job.dependencies().reserve(1, GFP_KERNEL)?;
+
+        // If the registration below gets registered successfully, a signaling
+        // fence will decrement the atomic. That could race. Thus, increment in
+        // advance. Ordering is ensured thanks to the dma_fence backend.
+        job.nr_of_deps.fetch_add(1, Relaxed);
+
+        // SAFETY: The `registration` is not forgotten. It drops with JobQueue.
+        let registration = unsafe { FenceCallbackRegistration::new(fence, waker) };
+        match KBox::pin_init(registration, GFP_KERNEL) {
+            Err(e) => {
+                let _ = job.nr_of_deps.fetch_sub(1, Relaxed);
+                if e == ENOENT {
+                    // Was already signaled. No reason to bother the caller.
+                    return Ok(());
+                }
+                return Err(e);
+            }
+            Ok(dep) => {
+                if let Err(e) = job.dependencies().push_within_capacity(dep) {
+                    // Impossible because of the reservation.
+                    pr_err!("Job::add_dependency(): reserved memory not available.\n");
+                    return Err(e.into());
+                }
+            }
+        }
+
+        Ok(())
+    }
+}
+
+#[pin_data]
+#[repr(C)]
+struct JobInternal<'b, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    links: ListLinks,
+    cost: u32,
+    fence_allocation: ListArcField<Option<DriverFenceAllocation<'b, DriverDataWrapper<T>>>, 0>,
+    fence: ListArcField<Option<DriverFence<'b, DriverDataWrapper<T>>>>,
+    dependencies: ListArcField<KVec<Pin<KBox<FenceCallbackRegistration<DependencyWaker<'b, T>>>>>>,
+    nr_of_deps: Atomic<u32>,
+    jq: &'b JobQueue<'b, T>,
+}
+
+impl_list_arc_safe! {
+    impl{'b, T: JobQueueOps + Send + Sync} ListArcSafe<0> for JobInternal<'b, T> { untracked; }
+}
+impl_list_item! {
+    impl{'b, T: JobQueueOps + Send + Sync} ListItem<0> for JobInternal<'b, T> { using ListLinks { self.links }; }
+}
+
+impl<'b, T: JobQueueOps + Send + Sync> JobInternal<'b, T> {
+    //    const LIST_JOB_ID: u64 = 0xe7e445f2bb9e97fc;
+
+    kernel::list::define_list_arc_field_getter! {
+        pub(crate) fn fence_allocation(&mut self<0>) -> &mut Option<DriverFenceAllocation<'b, DriverDataWrapper<T>>> { fence_allocation }
+        pub(crate) fn fence(&mut self<0>) -> &mut Option<DriverFence<'b, DriverDataWrapper<T>>> { fence }
+        pub(crate) fn dependencies(&mut self<0>) -> &mut KVec<Pin<KBox<FenceCallbackRegistration<DependencyWaker<'b, T>>>>> { dependencies }
+    }
+}
+
+#[pin_data]
+struct SubmitWorker<'a, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    jq: &'a JobQueue<'a, T>,
+}
+
+impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for SubmitWorker<'_, T> {
+    fn run(work: &ScopedWorkRef<Self>) {
+        // Prevent work-item UAF if the JQ is trying to drop right now.
+        let Some(jq_accessor) = work.jq.inner.try_access() else {
+            return;
+        };
+
+        let mut jq = jq_accessor.lock();
+
+        while let Some(mut job) = jq.as_mut().project().waiting_jobs.pop_front() {
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
+            let seqno = job
+                .fence()
+                .as_ref()
+                .expect("fence not present")
+                .as_fence()
+                .seqno();
+            let runnable_job = JobRunnable {
+                seqno,
+                data: job.fence().as_ref().expect("fence not present").deref(),
+            };
+
+            let jq_data = work.jq.fctx.deref().deref();
+
+            drop(jq); // Release lock.
+            T::run_job(jq_data, runnable_job);
+            jq = jq_accessor.lock(); // Retake lock.
+
+            // run_job() above needs to be called without lock protection. Thus,
+            // it is possible that the driver instructed completion right before
+            // we could re-take the lock.
+            if jq.last_completed >= seqno {
+                if let Some(fence) = job.fence() {
+                    fence.signal(Ok(()));
+                } else {
+                    panic!("fence not present.");
+                }
+
+                // We drop this job here directly, from work_item context.
+            } else {
+                jq.running_jobs.push_back(job);
+            }
+        }
+    }
+}
+
+#[pin_data]
+struct DropWorker<'a, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    jq: &'a JobQueue<'a, T>,
+}
+
+impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, T> {
+    fn run(work: &ScopedWorkRef<Self>) {
+        // Contrary to the SubmitWorker, this worker would probably never need
+        // this revocable guard, since the worker is cancelled synchronously
+        // once the JQ drops. It cannot be restarted when JQ is dropping.
+        // But the inner JQ needs to be accessed through Revocable anyways, so
+        // we get more robustness for free.
+        let Some(jq_accessor) = work.jq.inner.try_access() else {
+            return;
+        };
+
+        let mut jq = jq_accessor.lock();
+
+        while let Some(_job) = jq.drop_list.pop_front() {
+            // Droppy-dy-drop
+        }
+    }
+}
+
+#[pin_data]
+struct JobQueueInner<'a, T: JobQueueOps + Send + Sync> {
+    /// Fence sequence number of the last job the user has completed.
+    #[pin]
+    /// List of jobs waiting to be run on the hardware.
+    waiting_jobs: List<JobInternal<'a, T>>,
+    #[pin]
+    /// Jobs that are currently executing on the hardware.
+    running_jobs: List<JobInternal<'a, T>>,
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
+    drop_list: List<JobInternal<'a, T>>,
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
+/// A JobQueue must only ever drop in process context.
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
+/// let dependency = fctx.new_fence_allocation(())?.new_fence();
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
+/// struct JobData {
+///     data: CString,
+/// }
+///
+/// impl JobQueueOps for JqData {
+///     type JobDataType = JobData;
+///
+///     fn run_job<'a>(&self, job: JobRunnable<'a, JobData>) {
+///
+///     }
+/// }
+///
+/// let jq_data = JqData::new();
+/// let jq = KBox::pin_init(JobQueue::new(0, driver_name, timeline_name, 1000, jq_data), GFP_KERNEL)?;
+///
+/// struct Callback {}
+///
+/// impl FenceCallback for Callback {
+///     fn on_signal(&mut self) {
+///
+///     }
+/// }
+///
+/// let data = CString::try_from_fmt(fmt!("hello there!"))?;
+/// let data = JobData { data };
+///
+/// // TODO RFC:
+/// // This is the problem where self-references come into play.
+/// // Jobs need a reference to the JobQueue due to their DependencyWaker
+/// // callbacks. At the same time, the JobQueue owns the jobs.
+/// // So the following outcommented code would not compile.
+/// // Gary is working on a solution for that.
+///
+/// //let job1 = jq.new_job(data)?;
+/// // job1.add_dependency(dependency.as_fence())?;
+/// //let job2 = jq.new_job(data)?;
+/// //jq.submit(job1);
+/// //jq.submit(job2);
+///
+/// //drop(job);
+/// //drop(jq);
+///
+/// Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct JobQueue<'a, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    drop_worker: ScopedWork<DropWorker<'a, T>>,
+    #[pin]
+    // Revocable to prevent work-item UAF on `inner`.
+    inner: Revocable<SpinLockIrq<JobQueueInner<'a, T>>>,
+    #[pin]
+    fctx: FenceContext<DriverDataWrapper<T>>,
+    #[pin]
+    submit_worker: ScopedWork<SubmitWorker<'a, T>>,
+}
+
+// SAFETY: The JobQueue is locked and pinned.
+unsafe impl<T: JobQueueOps + Send + Sync> Sync for JobQueue<'_, T> {}
+// SAFETY: The JobQueue is locked and pinned.
+unsafe impl<T: JobQueueOps + Send + Sync> Send for JobQueue<'_, T> {}
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
+impl<'a, T: JobQueueOps + Send + Sync> JobQueue<'a, T> {
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
+        try_pin_init!(&this in Self {
+            inner <- Revocable::new(new_spinlock_irq!(try_pin_init!(JobQueueInner {
+                capacity,
+                last_completed: 0,
+                waiting_jobs: List::new(),
+                running_jobs: List::new(),
+                drop_list: List::new(),
+                // SAFETY: `this` is valid. The lifetimes ensure that the reference remains valid.
+            }))),
+            fctx <- FenceContext::new(initial_seqno, &driver_name, &timeline_name, DriverDataWrapper::new(data)),
+            // SAFETY: `this` is valid. The lifetimes ensure that the reference remains valid.
+            submit_worker <- new_scoped_work!("JobQueueSubmitWorker", Ok(SubmitWorker { jq: unsafe { &*this.as_ptr() } })),
+            // SAFETY: `this` is valid. The lifetimes ensure that the reference remains valid.
+            drop_worker <- new_scoped_work!("JobQueueDropWorker", Ok(DropWorker { jq: unsafe { &*this.as_ptr() } })),
+        })
+    }
+
+    /// Create a new job.
+    ///
+    /// The `cost` specified here is what JobQueue subtracts from its capacity
+    /// to determine whether a job is runnable, i.e., has space on the GPU ring.
+    ///
+    /// The `data` contained by a job will be borrowed back to the driver once
+    /// the jobs shall be run through [`JobQueueOps::run_job`].
+    pub fn new_job(&'a self, cost: u32, data: T::JobDataType) -> Result<Job<'a, T>> {
+        let fence_allocation = self.fctx.new_fence_allocation(data)?;
+        let job = try_pin_init!(JobInternal {
+            links <- ListLinks::new(),
+            cost,
+            fence_allocation: ListArcField::new(Some(fence_allocation)),
+            fence: ListArcField::new(None),
+            nr_of_deps: Atomic::new(0),
+            dependencies <- ListArcField::new(KVec::new()),
+            jq: &self,
+        });
+
+        let inner = ListArc::pin_init(job, GFP_KERNEL)?;
+
+        Ok(Job { inner })
+    }
+
+    // TODO RFC the lifetime ensures that only jobs can be submitted that were
+    // actually created on this JQ, right?
+    /// Submit a job that has previously been created with [`JobQueue::new_job()`].
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
+    pub fn submit(&self, job: Job<'a, T>) -> ARef<Fence> {
+        // unwrap() can't fire because `self` is valid.
+        let jq = self.inner.try_access().unwrap();
+        // The lock orders setting of the sequence number, so no driver lock is needed.
+        let mut jq = jq.lock();
+        let mut job = job.inner;
+        let fence = job
+            .fence_allocation()
+            .take()
+            .expect("fence_allocation not present")
+            .new_fence();
+
+        let ret_fence = ARef::from(fence.as_fence());
+
+        *job.fence() = Some(fence);
+
+        jq.waiting_jobs.push_back(job);
+        drop(jq);
+        self.check_start_submit_worker();
+
+        ret_fence
+    }
+
+    fn check_start_submit_worker(&self) {
+        // TODO this shouldn't be the system wq
+        // SAFETY: The worker is carried by the JobQueue and, thus, cannot be
+        // forgotten.
+        let _ = unsafe { workqueue::system_dfl().enqueue_scoped(&self.submit_worker) };
+    }
+
+    fn check_start_drop_worker(&self) {
+        // TODO this shouldn't be the system wq
+        // SAFETY: The worker is carried by the JobQueue and, thus, cannot be
+        // forgotten.
+        let _ = unsafe { workqueue::system_dfl().enqueue_scoped(&self.drop_worker) };
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
+    // TODO RFC: should seqno be inclusive? [0,seqno] <-> [0,seqno[ ?
+    pub fn complete_jobs_up_to_seqno(&self, seqno: u64) {
+        let needs_drop = core::mem::needs_drop::<T::JobDataType>();
+        // unwrap() can't fire because `self` is valid.
+        let jq = self.inner.try_access().unwrap();
+        let mut jq_locked = jq.lock();
+        let mut jq = jq_locked.as_mut().project();
+
+        if seqno < *jq.last_completed {
+            return;
+        }
+
+        while let Some(mut job) = jq.running_jobs.pop_front() {
+            if job
+                .fence()
+                .as_mut()
+                .expect("fence not present")
+                .as_fence()
+                .seqno()
+                > seqno
+            {
+                jq.running_jobs.push_front(job);
+                break;
+            }
+
+            *jq.capacity += u64::from(job.cost);
+
+            // This enables the SubmitWorker to complete a job that is not yet
+            // in 'running_jobs', in case of a race against the lock.
+            *jq.last_completed = seqno;
+
+            if let Some(fence) = job.fence() {
+                fence.signal(Ok(()));
+            } else {
+                panic!("fence not present.");
+            }
+
+            if needs_drop {
+                jq.drop_list.push_back(job);
+            }
+            // Otherwise, job is dropped here directly. Its fence won't perform
+            // an RCU grace period wait.
+        }
+
+        drop(jq_locked);
+
+        self.check_start_submit_worker();
+        if needs_drop {
+            self.check_start_drop_worker();
+        }
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
+    pub fn teardown<E>(self, error: Error)
+    where
+        Error: From<E>,
+    {
+        let jq = self.inner.try_access().unwrap();
+        let mut jq = jq.lock();
+
+        while let Some(mut job) = jq.running_jobs.pop_front() {
+            if let Some(fence) = job.fence() {
+                fence.signal(Err(error));
+            } else {
+                panic!("fence not present.");
+            }
+        }
+    }
+}
+
+#[pinned_drop]
+impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Revoke to prevent still existing DependencyWakers from kicking the
+        // SubmitWorker again before we could deregister them.
+        let _ = self.inner.revoke();
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
2.55.0

