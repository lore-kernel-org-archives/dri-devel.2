Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF81ECA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DF310EB40;
	Fri,  9 Oct 2026 19:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fIstdx/Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9492910EB40
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:14:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 065FD60DC8;
 Fri,  9 Oct 2026 19:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFDC1F000FF;
 Fri,  9 Oct 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573298;
 bh=YdUOuicLgqQU2RqlJunP0Guxj52QNgrq8QK2vLYlLQI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fIstdx/ZWjr3ZuMdTmgaGUqJVFC3wZb08v/BVZv+Wv8q9Bcf8288/anOZoGGq3+dy
 nZ0aAWhyrtGHbOaJlHZSzx9o/JCL63zH1bmr28rkvz1iPUCN3cj1JcZuzJzhhilZgg
 BcA6CtsKFMG01xeZuji2jP/EYmPP9fyxSeACZla1nrPVq8sAFItfn82ih4A0oXWsBs
 tnmcFUWpQiKp+ccYGQn+QqDy3EameV2gxjcl5UcT+GDNif+fD15JbbQPd8N0AU/tGO
 eI8TqTLX3jUCEubliJ1efeflIZWKj47AXWkkef+wrNSNUfMV3tdhOFJrcsJlWjQDsO
 oNZvtGz8ygZLg==
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
Subject: [RFC PATCH v5 6/6] rust: drm: Add JobQueue
Date: Fri,  9 Oct 2026 21:11:24 +0200
Message-ID: <20261009191124.1022902-8-phasta@kernel.org>
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
 rust/kernel/drm/job_queue.rs | 525 +++++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs       |   4 +
 2 files changed, 529 insertions(+)
 create mode 100644 rust/kernel/drm/job_queue.rs

diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
new file mode 100644
index 000000000000..b5c7f4ecb3f4
--- /dev/null
+++ b/rust/kernel/drm/job_queue.rs
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Red Hat Inc.
+ * Author: Philipp Stanner <pstanner@redhat.com>
+ */
+
+//! DRM's job dependency manager and load balancer for GPUs with firmware
+//! scheduling, i.e., GPUs that spawn one ring per user context.
+//!
+//! JobQueue abstracts the entire handling of [`dma_buf::FenceContext`] and its
+//! associated fences for the user.
+//!
+//! Jobs created on the JobQueue take over ownership of userspace provided data
+//! and prepare all memory allocations. A later job submission sets up the fence
+//! and performs no fallible operations. A fence sequence number always
+//! corresponds 1:1 with the job sequence number.
+//!
+//! Before jobs are submitted, dependencies in the form of [`dma_buf::Fence`]
+//! can be set on them. Jobs get submitted by the JobQueue in process context
+//! through a work item in FIFO order. Only jobs whose dependency fences have
+//! all been signaled get submitted. If the front job's dependency is not yet
+//! fullfilled, the JobQueue pauses until that's the case.
+//!
+//! The driver tells the JobQueue which jobs are finished through
+//! [`JobQueue::complete_jobs_up_to_seqno`].
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
+        FenceContext,
+        FenceCallback,
+        FenceCallbackRegistration,
+        FenceContextOps, //
+    },
+    list::*,
+    revocable::Revocable,
+    str::CString,
+    sync::{
+        aref::ARef,
+        SpinLockIrq,
+        new_spinlock_irq,
+        atomic::{
+            Atomic,
+            Relaxed, //
+        }, //
+    }, //
+    workqueue::{
+        self,
+        new_scoped_work,
+//        ScopedQueue,
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
+        // Last dependency kicks off the worker.
+        if self.nr_of_deps.fetch_sub(1, Relaxed) == 1 {
+            if let Some(jq) = self.jq.inner.try_access() {
+                let mut jq = jq.deref().lock();
+                jq.as_mut().check_start_submit_worker();
+            }
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
+    /// Add `fence` as a dependency for this job.
+    ///
+    /// A JobQueue will only push a job once all dependency fences have been
+    /// signaled.
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
+            },
+            Ok(dep) => {
+                if let Err(e) = job.dependencies().push_within_capacity(dep) {
+                    // Impossible because of the reservation.
+                    pr_err!("Job::add_dependency(): reserved memory not available.\n");
+                    return Err(e.into());
+                }
+            },
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
+
+impl<'b, T: JobQueueOps + Send + Sync> JobInternal<'b, T> {
+//    const LIST_JOB_ID: u64 = 0xe7e445f2bb9e97fc;
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
+        let Some(jq_accessor) = work.jq.inner.try_access() else {
+            return;
+        };
+
+        let mut jq = jq_accessor.lock();
+
+        while let Some(mut job) = jq.as_mut().project().waiting_jobs.pop_front() {
+            let new_capacity = jq.capacity as i64 - job.cost as i64;
+            if new_capacity < 0 {
+                break;
+            }
+            *jq.as_mut().project().capacity = new_capacity as u64;
+
+            let runnable_job = JobRunnable {
+                seqno: job.fence().as_ref().expect("fence not present").as_fence().seqno(),
+                data: job.fence().as_ref().expect("fence not present").deref(),
+            };
+
+            let jq_data = work.jq.fctx.deref().deref();
+
+            drop(jq);
+            T::run_job(jq_data, runnable_job);
+            // The driver could now have taken the lock here and try to complete
+            // this very job. It would then not get signaled because it was not
+            // yet in the running list. However, since the driver completes jobs
+            // by sequence number, its subsequent calls to jq.complete_jobs_up_to_seqno()
+            // will signal this job, because then it will be in the running_jobs
+            // list.
+            // We accept this race because it makes the implementation much
+            // simpler and avoids locking issues. Otherwise, complete_jobs_up_to_seqno()
+            // would need a distinct signaler-object-list to avoid races between
+            // this work item and said function.
+            jq = jq_accessor.lock();
+
+            jq.as_mut().project().running_jobs.push_back(job);
+        }
+
+        // Now clean up all already-signaled jobs, dropping their fences.
+        let mut jq = jq.as_mut().project();
+
+        let mut cursor = jq.running_jobs.cursor_front();
+
+        while let Some(job) = cursor.peek_next() {
+            let mut job = job.remove();
+
+            if !job.fence().as_mut().expect("fence not present").as_fence().is_signaled() {
+                jq.running_jobs.push_front(job);
+                // Jobs complete in order. No point in checking the rest.
+                break;
+            }
+        }
+
+        *jq.submit_worker_active = false;
+    }
+}
+
+#[pin_data]
+struct JobQueueInner<'a, T: JobQueueOps + Send + Sync> {
+    submit_worker_active: bool,
+    #[pin]
+    submit_worker: ScopedWork<SubmitWorker<'a, T>>,
+    #[pin]
+    waiting_jobs: List<JobInternal<'a, T>>,
+    #[pin]
+    running_jobs: List<JobInternal<'a, T>>,
+    capacity: u64,
+}
+
+impl<T: JobQueueOps + Send + Sync> JobQueueInner<'_, T> {
+    fn check_start_submit_worker(self: Pin<&mut Self>) {
+        if self.submit_worker_active {
+            return;
+        }
+
+        // TODO this shouldn't be the system wq
+        // SAFETY: The worker is carried by the JobQueue and, thus, cannot be
+        // forgotten.
+        unsafe { workqueue::system_dfl().enqueue_scoped(&*self.submit_worker) };
+
+        *self.project().submit_worker_active = true;
+    }
+
+}
+
+/// A JobQueue.
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
+/// //let job = jq.new_job(data)?;
+/// //jq.submit(job);
+///
+/// //drop(job);
+/// //drop(jq);
+///
+/// Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct JobQueue<'a, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    // Revocable to prevent a DependencyWaker firing in the moment of JQ-drop
+    // from deadlocking.
+    inner: Revocable<SpinLockIrq<JobQueueInner<'a, T>>>,
+    #[pin]
+    fctx: FenceContext<DriverDataWrapper<T>>,
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
+    /// Returns true if the job was run, false if there was no capacity.
+    /// In case of an other error, the driver's callback implementation likely
+    /// wants to trigger termination of the ring and, thus, dropping of the
+    /// respective [`JobQueue`].
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
+        where
+            Error: From<E>,
+            E: From<Infallible>,
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
+                submit_worker_active: false,
+                // SAFETY: `this` is valid. The lifetimes ensure that the reference remains valid.
+                submit_worker <- new_scoped_work!("JobQueueSubmitWorker", Ok(SubmitWorker { jq: unsafe { &*this.as_ptr() } })),
+                waiting_jobs: List::new(),
+                running_jobs: List::new(),
+                capacity,
+            }))),
+            fctx <- FenceContext::new(initial_seqno, &driver_name, &timeline_name, DriverDataWrapper::new(data)),
+        })
+    }
+
+    /// Create a new job.
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
+    /// one go, including setting of the fence sequence numbers. Thus, it is
+    /// typically unnecessary (and advaised against) calling this function with
+    /// a driver lock held.
+    // Mutable `self` so that the user is forced to ensure synchronization.
+    // That's a bit better so that the fence sequence numbers stay ordered.
+    pub fn submit(&mut self, job: Job<'a, T>) -> ARef<Fence> {
+        // unwrap() can't fire because `self` is valid.
+        let jq = self.inner.try_access().unwrap();
+        // The lock orders setting of the sequence number, so no driver lock is needed.
+        let mut jq = jq.lock();
+        let mut job = job.inner;
+        let fence = job.fence_allocation().take().expect("fence_allocation not present").new_fence();
+
+        let ret_fence = ARef::from(fence.as_fence());
+
+        *job.fence() = Some(fence);
+
+        jq.as_mut().project().waiting_jobs.push_back(job);
+        jq.as_mut().check_start_submit_worker();
+
+        ret_fence
+    }
+
+    /// Complete all the jobs in the queue's running_list, up to `seqno`.
+    ///
+    /// This signals the jobs' fences and drops both job and fence.
+    ///
+    /// This function tells the implementation that there is now more capacity
+    /// for more jobs to be pushed into the GPU ring.
+    pub fn complete_jobs_up_to_seqno(&self, seqno: u64, status: Result) {
+        // unwrap() can't fire because `self` is valid.
+        let jq = self.inner.try_access().unwrap();
+        let mut jq_locked = jq.lock();
+        let mut jq = jq_locked.as_mut().project();
+
+        let mut cursor = jq.running_jobs.cursor_front();
+
+        while let Some(job) = cursor.peek_next() {
+            let mut job = job.remove();
+
+            if job.fence().as_mut().expect("fence not present").as_fence().seqno() > seqno {
+                jq.running_jobs.push_front(job);
+                break;
+            }
+
+            *jq.capacity += job.cost as u64;
+
+            if let Some(fence) = job.fence() {
+                fence.signal(status);
+            } else {
+                panic!("fence not present.");
+            }
+        }
+
+        jq_locked.as_mut().check_start_submit_worker();
+    }
+}
+
+#[pinned_drop]
+impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Prevent all dependency callbacks (and the submit_worker) from running
+        // into `self.inner`. Drops the DependencyWaker objects, deregistering
+        // their events on foreign fences. Thus, this revoke also protects against
+        // deadlock since deregistering takes the fence locks in reverse order
+        // to the JobQueue lock, which we would need here without the Revocable
+        // for said deregistering.
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

