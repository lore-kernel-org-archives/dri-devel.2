Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56EDCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259B410EE34;
	Tue, 29 Sep 2026 10:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SnTDMXHq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591B510EE3F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:50:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F2AA43737;
 Tue, 29 Sep 2026 10:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2881F00899;
 Tue, 29 Sep 2026 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679018;
 bh=bE3s+e1DzIOTyxw982X6GmqDR8ov4lgMZsEIQFuJP+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SnTDMXHqT65UCiL7UaWrqzCtLHzphozXv+kEdRSBFL1sHRCYEvmIYbiFRGkmnlgDA
 012tJQpdoLcJfdVkJ5JCOpgqpeL+CV4QgDHRwVQMUYPcEokb7hCMSmiJXAyYk9X9PY
 P1vVfBkxn5C0cBrjp5A0C/B5kWYuyo0v7vKjePukSKrAttSW62gqP+JjGpHuWIrhvE
 ZK4K6I8xzd04GyWaGqej8rlnc6XtezryVRGg30TMsUPBMua669LJEHrwO/cPxzWF9d
 8yF62/8IckFErlxIkI+uj7XlknHi0XoyXBDHf7kmeT+11EaLr6DlyKJjuFa4sskApW
 Ub63d0EgvXe1A==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
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
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v4 3/3] rust: drm: Add JobQueue
Date: Tue, 29 Sep 2026 12:47:03 +0200
Message-ID: <20260929104703.934128-5-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929104703.934128-2-phasta@kernel.org>
References: <20260929104703.934128-2-phasta@kernel.org>
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

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/drm/job_queue.rs | 493 +++++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs       |   4 +
 2 files changed, 497 insertions(+)
 create mode 100644 rust/kernel/drm/job_queue.rs

diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
new file mode 100644
index 000000000000..9a6bc1e8fffc
--- /dev/null
+++ b/rust/kernel/drm/job_queue.rs
@@ -0,0 +1,493 @@
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
+            // FIXME:
+            // I suspect that this is still the same deadlock-danger versus JQ's
+            // drop() that we solved previously with Revocable.
+            //
+            // If JQ drops, it takes the JQ-lock to deregister its waker callbacks
+            // on all external dependency Fences, thereby taking the fence lock.
+            // If one of those fences signal at that moment, first the fence lock
+            // will be taken, and then the JQ lock here -> deadlock.
+            //
+            // So we likely want to add the Revocable-solution from the first
+            // drafts again.
+            let mut jq = self.jq.inner.lock();
+            jq.as_mut().check_start_submit_worker();
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
+        // SAFETY: The `waker` is not forgotten.
+        let registration = unsafe { FenceCallbackRegistration::new(fence, waker) };
+        match KBox::pin_init(registration, GFP_KERNEL) {
+            Err(e) => {
+                let _ = job.nr_of_deps.fetch_sub(1, Relaxed);
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
+        let fctx_data = work.jq.fctx.deref().deref();
+        let mut jq = work.jq.inner.lock();
+        let mut jq = jq.as_mut().project();
+
+        let mut cursor = jq.waiting_jobs.cursor_front();
+
+        while let Some(job) = cursor.peek_next() {
+            if job.nr_of_deps.load(Relaxed) > 0 {
+                break;
+            }
+
+            let mut job = job.remove();
+            let runnable_job = JobRunnable {
+                seqno: job.fence().as_ref().expect("fence not present").as_fence().seqno(),
+                data: job.fence().as_ref().expect("fence not present").deref(),
+            };
+
+            if !T::run_job(fctx_data, runnable_job) {
+                // There was no capacity left. The driver will invoke the JobQueue
+                // later again.
+                jq.waiting_jobs.push_front(job);
+                break;
+            }
+
+            jq.running_jobs.push_back(job);
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
+///     fn run_job<'a>(&self, job: JobRunnable<'a, JobData>) -> bool {
+///
+///         true
+///     }
+/// }
+///
+/// let jq_data = JqData::new();
+/// let jq = KBox::pin_init(JobQueue::new(0, driver_name, timeline_name, jq_data), GFP_KERNEL)?;
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
+/// //drop(jq);
+///
+/// Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct JobQueue<'a, T: JobQueueOps + Send + Sync> {
+    #[pin]
+    inner: SpinLockIrq<JobQueueInner<'a, T>>,
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
+    fn run_job<'a>(&self, job: JobRunnable<'a, Self::JobDataType>) -> bool;
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
+        data: impl PinInit<T, E>,
+    ) -> impl PinInit<Self, Error>
+    where
+        Error: From<E>,
+        E: From<Infallible>,
+    {
+        try_pin_init!(&this in Self {
+            inner <- new_spinlock_irq!(try_pin_init!(JobQueueInner {
+                submit_worker_active: false,
+                // SAFETY: `this` is valid. The lifetimes ensure that the reference remains valid.
+                submit_worker <- new_scoped_work!("JobQueueSubmitWorker", Ok(SubmitWorker { jq: unsafe { &*this.as_ptr() } })),
+                waiting_jobs: List::new(),
+                running_jobs: List::new(),
+            })),
+            fctx <- FenceContext::new(initial_seqno, &driver_name, &timeline_name, DriverDataWrapper::new(data)),
+        })
+    }
+
+    /// Create a new job.
+    pub fn new_job(&'a self, data: T::JobDataType) -> Result<Job<'a, T>> {
+        let fence_allocation = self.fctx.new_fence_allocation(data)?;
+        let job = try_pin_init!(JobInternal {
+            links <- ListLinks::new(),
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
+    // Mutable `self` so that the user is forced to ensure synchronization.
+    // That's a bit better so that the fence sequence numbers stay ordered.
+    pub fn submit(&mut self, job: Job<'a, T>) -> ARef<Fence> {
+        let mut job = job.inner;
+        let fence = job.fence_allocation().take().expect("fence_allocation not present").new_fence();
+
+        let ret_fence = ARef::from(fence.as_fence());
+
+        *job.fence() = Some(fence);
+
+        let mut inner = self.inner.lock();
+
+        inner.as_mut().project().waiting_jobs.push_back(job);
+        inner.as_mut().check_start_submit_worker();
+
+        ret_fence
+    }
+
+    /// Complete all the jobs in the queue's running_list, up to `seqno`.
+    ///
+    /// This signals the jobs' fences and drops both job and fence.
+    pub fn complete_jobs_up_to_seqno(&self, seqno: u64, status: Result) {
+        let mut jq = self.inner.lock();
+        let mut jq = jq.as_mut().project();
+
+        let mut cursor = jq.running_jobs.cursor_front();
+
+        while let Some(job) = cursor.peek_next() {
+            let mut job = job.remove();
+
+            // TODO RFC I couldn't figure out how to access job.fence without removing first:
+            // `if job.deref().fence.get_mut().unwrap().as_fence().seqno() > seqno {` ???
+            if job.fence().as_mut().expect("fence not present").as_fence().seqno() > seqno {
+                jq.running_jobs.push_front(job);
+                return;
+            }
+
+            job.fence().take().expect("fence not present").signal(status);
+        }
+    }
+
+    // RFC:
+    // Do we want to provide a method like 
+    //
+    // pub fn complete_front_job() -> T
+    //
+    // that returns the user's data T so that it can be freed in a deferred
+    // manner should T's drop() do something illegal in atomic context?
+    //
+    // That way the JobQueue would not have to handle dropping through its own
+    // workqueue, which might be problematic synchronization-wise.
+    //
+    // I suppose it depends on how common the use-case is, i.e., what kind of
+    // data a job typically carries.
+    //
+    // On the other hand, the job's data T with this implementation lives in
+    // DriverFence's T, which already is being dropped with call_rcu(). So it
+    // might be worth at least considering whether rcu_work() might address that?
+}
+
+#[pinned_drop]
+impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        self.complete_jobs_up_to_seqno(u64::MAX, Err(ECANCELED));
+        // TODO: Warn if JQ drops with remaining jobs. Or maybe not? It is being
+        // proposed to drop things implicitly.
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

