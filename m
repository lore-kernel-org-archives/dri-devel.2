Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E68606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otYr5Tol
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CEB10F575;
	Tue, 24 Nov 2026 12:55:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CC610F575
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:55:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4DC2446C4;
 Tue, 24 Nov 2026 12:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511FB1F000CA;
 Tue, 24 Nov 2026 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795524923;
 bh=ckFy0crE+MdZ5tzixd60omUYYrVI4tEbny98pMtL1is=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=otYr5Tol0ftoLBKyTFpinAWEL1/QiHgDNEstCUrwVZ6iE/sCAI81rQhaINHhlJa10
 LDiSnYjjQcMyzOBF4Z0E2WdFY2MNXzUwmJkHa8mVxAMIdGZLQ86KsgIlBOogIszRM6
 mg823FbnMJ46GT1kqZijQC14dyN7DHbY/Mx3siiC98UtYBikmUK+C5RdDwOCDzzXj0
 OY5O/yyyzclGbf2LBWzBXU/C/RIw2jqVWyM46FgJ6tFliGmr9RGuYSSfoxt6I4wz3Q
 ZYVs0IiwgD+dMk4P0ATcw02Wz56F8CXRtoFEefK+6oBNsZYCac6xa8r/2b//G3eDRy
 MMxvVIIRcyHBA==
Message-ID: <sashiko-outbox-231183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] rust: drm: Add JobQueue
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261124122951.878199-11-phasta@kernel.org>
References: <20261124122951.878199-2-phasta@kernel.org>
 <20261124122951.878199-11-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:55:22 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential
issues to consider:
- [High] rust: dma_fence: payload destructor skipped in
  DriverFence::drop()
- [High] rust: drm: unsound lifetime transmute, aliasing, and teardown
  in JobQueue
- [High] rust: drm: fence signaling and job drop under SpinLockIrq in
  JobQueue
- [High] rust: drm: missing Signed-off-by trailer for Co-developed-by
  author
- [Medium] rust: drm: unscheduled DropWorker in RunWorker::run() on
  completion race
- [Medium] rust: drm: unsignaled waiting_jobs and serial RCU waits in
  JobQueue::drop()
- [Medium] rust: drm: RunWorker::run() does not re-check parked inside
  job loop
- [Medium] rust: drm: signed i64 cast of u64 capacity in
  RunWorker::run()
- [Medium] drm: rust: missing Release-Acquire ordering on nr_of_deps in
  job_queue
- [Low] rust: drm: spurious worker wakeups in
  complete_jobs_up_to_seqno()
- [Low] rust: drm: JobQueue doctest passes PinInit closure to
  KBox::new()
- [Low] rust: drm: non-vertical imports, broken doc links, and missing
  #[inline]
--

commit 1aa6ded0089a768fb2d0e487607dde049d292e4e
Author: Philipp Stanner <phasta@kernel.org>

rust: drm: Add JobQueue

This commit adds JobQueue, a Rust component for managing GPU job
dependencies, credit accounting, and dma_fence lifetimes for GPUs with
firmware scheduling.

> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Co-developed-by: Gary Guo <gary@garyguo.net>
>
> (^ waiting for Gary to sign-off)

[Severity: High]
Per Documentation/process/submitting-patches.rst, a Co-developed-by
trailer must be immediately followed by the co-author's Signed-off-by
trailer, with the submitter's Signed-off-by last, and the draft note
removed before merging.

> diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
> new file mode 100644
> index 0000000000000..3d3d78fda5514
> --- /dev/null
> +++ b/rust/kernel/drm/job_queue.rs
> @@ -0,0 +1,863 @@

[ ... ]

> +//! Since jobs might contain data that must not drop in atomic context, =
and
> +//! since jobs' [`dma_buf::DriverFence`]s perform a call to
> +//! [`rcu::synchronize_rcu()`], they are dropped through a work item if =
[`Drop`]
> +//! is implemented for the job's payload data.

[ ... ]

> +use kernel::{
> +    dma_buf::dma_fence::{
> +        DriverFence,
> +        DriverFenceAllocation,
> +        Fence,
> +        FenceCallback,
> +        FenceCallbackRegistration,
> +        FenceContext,
> +        FenceContextOps, //
> +    },
> +    list::{
> +        impl_list_arc_safe,
> +        impl_list_item,
> +        List,
> +        ListItem,
> +        ListLinks, //
> +    },
> +    new_srcu,
> +    prelude::*,
> +    str::CString,
> +    sync::{
> +        aref::ARef,
> +        atomic::{
> +            Atomic,
> +            Relaxed, //
> +        },
> +        new_spinlock_irq,
> +        SpinLockIrq, //
> +    }, //
> +    sync::{
> +        atomic::AtomicFlag,
> +        Srcu, //
> +    },
> +    sync::{Arc, UniqueArc},
> +    workqueue::{
> +        new_scoped_work,
> +        OwnedQueue,
> +        Queue,
> +        ScopedWork,
> +        ScopedWorkItem, //
> +    }, //
> +};

[Severity: Low]
This isn't a bug, but the kernel::sync imports are split across three
separate sync:: blocks with sync::{Arc, UniqueArc} on a single line rather
than following the vertical import style in
Documentation/rust/coding-guidelines.rst.

Also, the rustdoc intra-doc links to dma_buf::FenceContext,
dma_buf::DriverFence, dma_buf::Fence, and rcu::synchronize_rcu() do not
resolve because dma_buf and rcu are not in scope (and JobQueue::park()'s
doc comment has a single-colon typo in [JobQueue:unpark()]).  Finally, the
small wrapper and accessor methods in this module (such as UniqueList's
methods, DriverDataWrapper::deref, DriverDataWrapper::new,
JobQueue::deref, JobQueue::id, and JobQueue::set_error) are missing
#[inline].

[ ... ]

> +impl<'b, T: JobQueueOps + Send + Sync> FenceCallback for DependencyWaker=
<'b, '_, T> {
> +    fn on_signal(&mut self, _res: Result) {
> +        // Last dependency kicks the worker. This cannot cause UAF on JQ=
 if the
> +        // associated job was forgotten because only submitted jobs can =
reach 0.
> +        if self.nr_of_deps.fetch_sub(1, Relaxed) =3D=3D 1 {
> +            // The drop-order of JobQueue ensures that all DependencyWak=
ers are
> +            // cancelled before the JobQueue itself is dropped.
> +            self.jq.check_start_run_worker();
> +        }
> +    }
> +}

[ ... ]

> +    pub fn submit(self) -> ARef<Fence> {
> +        let jq =3D self.inner.jq;
> +        jq.with_inner(|inner| {
> +            // SAFETY: this is a lifetime transmute from `Job<'queue, T>=
` to
> +            // `Job<'fctx, T>`.
> +            //
> +            // `job` internally holds a reference to `JobQueue`, while w=
e are
> +            // now moving `job` into `inner`, which may borrow from `fct=
x` but
> +            // not the full `JobQueue`. So on surface this would be inco=
rrect.
> +            // However, as we drain `inner` inside `JobQueue::drop`, the
> +            // reference is gone before any field is destructed.
> +            let mut job =3D unsafe { core::mem::transmute::<Job<'_, T>, =
Job<'_, T>>(self) };
> +
> +            // The lock orders setting of the sequence number, so no dri=
ver lock is needed.
> +            let mut inner =3D inner.lock();
> +            let fence =3D job.fence_allocation.new_fence();
> +            let ret_fence =3D ARef::from(fence.as_fence());
> +
> +            *job.inner.as_mut().project().fence =3D Some(fence);
> +
> +            // Job is submitted now. Signaling dependencies are now allo=
wed to
> +            // kick the worker.
> +            let _ =3D job.inner.nr_of_deps.fetch_sub(1, Relaxed);
> +
> +            inner.waiting_jobs.push_back(job.inner);
> +            drop(inner);
> +            jq.check_start_run_worker();
> +
> +            ret_fence
> +        })
> +    }
> +}

[Severity: High]
Is erasing the &JobQueue<T> borrow lifetime in Job::submit() sound while
JobInternal and DependencyWaker still hold jq: &JobQueue<T>?

Because Job::submit() consumes Job<'queue, T>, the caller can obtain
Pin<&mut JobQueue<T>> for JobQueue::set_error() or PinnedDrop::drop()
while DependencyWaker callbacks in waiting_jobs are still active and can
dereference self.jq (&JobQueue<T>) concurrently on another CPU, violating
Rust's aliasing rules (and re-enqueuing run_worker during drop after
srcu.synchronize() has already completed).

In addition, DropWorker::run() pops a job from drop_list and releases
inner.lock() before calling drop(job), without taking srcu.read_lock() and
without JobQueue::drop() flushing drop_worker:

CPU0 (DropWorker::run)            CPU1 (JobQueue::drop)
----------------------            ---------------------
lock(inner)
job =3D drop_list.pop_front()
unlock(inner)
                                  parked.store(true)
                                  srcu.synchronize()
                                  drain inner lists
                                  // PinnedDrop::drop() returns;
                                  // JobQueue fields are dropped
drop(job)  <-- job still holds &JobQueue and &FenceContext

Two other lifetime issues affect teardown: in struct JobQueue,
drop_queue and run_queue (OwnedQueue) are declared before drop_worker and
run_worker (ScopedWork), so Rust drops the queues before cancelling their
ScopedWork items; and if an unsubmitted Job with a registered dependency
is forgotten via core::mem::forget (as discussed in Job::add_dependency())
and the JobQueue is later dropped, a signal on that fence still invokes
DependencyWaker::on_signal(&mut self) while self.jq is a dangling
&JobQueue<T>.

[ ... ]

> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for RunWorker<'_, '_, =
T> {
> +    fn run(work: &ScopedWork<Self>) {
> +        // Synchronize against revocation in `JobQueue::drop`.
> +        let _lock_guard =3D work.srcu.read_lock();
> +        if work.parked.load(Relaxed) {
> +            return;
> +        }
> +
> +        let mut jq =3D work.inner.lock();
> +
> +        while let Some(job) =3D jq.waiting_jobs.pop_front() {

[Severity: Medium]
Should RunWorker::run() also check work.parked inside the while loop?

work.parked is only checked once before entering the loop, and the lock is
released around T::run_job().  If JobQueue::park() or JobQueue::drop() is
called while T::run_job() is running, it sets self.parked to true and
waits in self.srcu.synchronize(), but RunWorker::run() will continue
popping and running all remaining ready jobs in waiting_jobs before
exiting the loop and releasing the SRCU read lock.

> +            // While we didn't hold the lock below for `run_job()`, it c=
ould be
> +            // that a new job entered the waiting list which has an unfu=
lfilled
> +            // dependency.
> +            if job.nr_of_deps.load(Relaxed) > 0 {
> +                jq.waiting_jobs.push_front(job);
> +                break;
> +            }

[Severity: Medium]
Does Relaxed ordering on nr_of_deps guarantee that T::run_job() observes
memory writes made before dependency fences were signaled?

If RunWorker::run() is already looping when the last dependency fence
signals on another CPU (or if a dependency signals before Job::submit()
performs the final decrement to 0), RunWorker::run() can observe
job.nr_of_deps.load(Relaxed) =3D=3D 0, unlock jq (a release operation), and
call T::run_job() without any acquire barrier synchronizing with the
dependency signal:

CPU0 (dependency signal)          CPU1 (RunWorker::run)
------------------------          ---------------------
// writes before fence signal
nr_of_deps.fetch_sub(1, Relaxed)
  // reaches 0
                                  lock(inner)
                                  nr_of_deps.load(Relaxed) =3D=3D 0
                                  unlock(inner)
                                  T::run_job()  <-- no acquire barrier

Using Release ordering on nr_of_deps.fetch_sub() in
DependencyWaker::on_signal() and Job::submit() paired with Acquire
ordering on job.nr_of_deps.load() in RunWorker::run() would establish a
release-acquire chain before T::run_job() runs.

> +            let new_capacity =3D jq.capacity as i64 - i64::from(job.cost=
);
> +            if new_capacity < 0 {
> +                jq.waiting_jobs.push_front(job);
> +                break;
> +            }
> +            *jq.as_mut().project().capacity =3D new_capacity as u64;

[Severity: Medium]
Can casting jq.capacity (u64) to i64 wrap negative or underflow when
capacity_param exceeds i64::MAX?

JobQueue::new() accepts any u64 for capacity_param, so if jq.capacity is
greater than i64::MAX as u64, jq.capacity as i64 becomes negative and
either permanently stalls the queue (new_capacity < 0) or underflows
i64::MIN.  Could this use jq.capacity.checked_sub(u64::from(job.cost))
instead?

> +
> +            let fence =3D job.fence.as_ref().expect("fence not present");
> +            let seqno =3D fence.as_fence().seqno();
> +            let runnable_job =3D JobRunnable {
> +                seqno,
> +                data: fence.deref(),
> +            };
> +
> +            drop(jq); // Release lock.
> +            T::run_job(work.fctx, runnable_job);
> +            jq =3D work.inner.lock(); // Retake lock.
> +
> +            // run_job() above needs to be called without lock protectio=
n. Thus,
> +            // it is possible that the driver instructed completion righ=
t before
> +            // we could re-take the lock.
> +            if jq.last_completed >=3D seqno {
> +                *jq.as_mut().project().capacity +=3D u64::from(job.cost);
> +                fence.signal(Ok(()));
> +
> +                // Drop here directly if possible. Otherwise, let the Dr=
opWorker
> +                // take care of it.
> +                if core::mem::needs_drop::<T::JobDataType>() {
> +                    jq.drop_list.push_back(job);
> +                }
> +            } else {
> +                jq.running_jobs.push_back(job);
> +            }
> +        }
> +    }
> +}

[Severity: Medium]
As reported by Younes Akhouayri on v1 [1], when a job completes before
RunWorker::run() retakes work.inner.lock(), does pushing the job onto
jq.drop_list here without scheduling drop_worker leave the job stranded?

In that race, complete_jobs_up_to_seqno() calls check_start_drop_worker()
before the job is on drop_list, so DropWorker::run() can see an empty list
and exit before RunWorker::run() pushes the job onto jq.drop_list.  The
job and its payload then remain unfreed in drop_list until a later job
completes or the JobQueue is dropped.

> +
> +struct DropWorker<'a, 'fctx, T: JobQueueOps + Send + Sync> {
> +    inner: &'a SpinLockIrq<JobQueueInner<'fctx, T>>,
> +}
> +
> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, '_,=
 T> {
> +    fn run(work: &ScopedWork<Self>) {
> +        let mut jq_locked =3D work.inner.lock();
> +
> +        while let Some(job) =3D jq_locked.drop_list.pop_front() {
> +            drop(jq_locked);
> +            drop(job);
> +            jq_locked =3D work.inner.lock();
> +        }
> +    }
> +}

[Severity: High]
When DropWorker::run() (or JobQueue::drop()) drops a job whose
T::JobDataType implements Drop, does DriverFence::drop() actually run the
payload's destructor?

In DriverFence::drop() (updated earlier in this series by commit "rust:
DmaFence: Replace call_rcu() with cond_synchronize_rcu()"), drop_in_place
is called on &raw mut self.data rather than on the inner payload field:

rust/kernel/dma_buf/dma_fence.rs:DriverFence::drop() {
    ...
        // SAFETY: Valid because `self` is valid. RCU above ensures that all
        // accessors are gone.
        unsafe { drop_in_place(&raw mut self.data) };

        // SAFETY: Valid because `self` is valid. This is the initial refer=
ence
        // from when this `DriverFence` was created.
        unsafe { bindings::dma_fence_put(self.as_raw()) };
}

Because DriverFence::data is a NonNull<DriverFenceData<'a, T>> pointer and
the user payload lives at (*self.data.as_ptr()).data,
drop_in_place(&raw mut self.data) is a no-op on a pointer wrapper and
dma_fence_put() frees the allocation without running T::JobDataType's
Drop implementation, leaking any resources owned by the job payload.

[ ... ]

> +/// let cb =3D Callback { seqno: done_fence2.seqno() };
> +/// // SAFETY: The registration is not leaked.
> +/// let reg =3D unsafe { FenceCallbackRegistration::new(&done_fence2, cb=
) };
> +/// let reg =3D KBox::new(reg, GFP_KERNEL)?;

[Severity: Low]
In this doctest example, FenceCallbackRegistration::new() returns an
impl PinInit, so KBox::new(reg, GFP_KERNEL)? boxes the unexecuted
initializer closure instead of registering the callback.  Should this be
KBox::pin_init(reg, GFP_KERNEL)?

[ ... ]

> +    pub fn complete_jobs_up_to_seqno(&self, seqno: u64) {
> +        self.with_inner(|inner| {
> +            let needs_drop =3D core::mem::needs_drop::<T::JobDataType>();
> +            let mut jq_locked =3D inner.lock();
> +            let mut jq =3D jq_locked.as_mut().project();
> +
> +            if seqno < *jq.last_completed {
> +                return;
> +            }
> +
> +            while let Some(mut job) =3D jq.running_jobs.pop_front() {
> +                if job
> +                    .as_mut()
> +                    .project()
> +                    .fence
> +                    .as_mut()
> +                    .expect("fence not present")
> +                    .as_fence()
> +                    .seqno()
> +                    > seqno
> +                {
> +                    jq.running_jobs.push_front(job);
> +                    break;
> +                }
> +
> +                *jq.capacity +=3D u64::from(job.cost);
> +
> +                let fence =3D job.fence.as_ref().expect("fence not prese=
nt");
> +                fence.signal(Ok(()));
> +
> +                if needs_drop {
> +                    jq.drop_list.push_back(job);
> +                }
> +                // Otherwise, job is dropped here directly. Its fence wo=
n't perform
> +                // an RCU grace period wait.
> +            }

[Severity: High]
Can calling fence.signal(Ok(())) and dropping job while holding
inner.lock() (SpinLockIrq) deadlock in complete_jobs_up_to_seqno() and
RunWorker::run()?

DriverFence::signal() acquires the fence spinlock and synchronously runs
registered FenceCallback::on_signal() callbacks while inner.lock() is
held.  If a completion callback submits another job via Job::submit() on
the same JobQueue, it will try to acquire inner.lock() on the same CPU:

complete_jobs_up_to_seqno()
  inner.lock()
  fence.signal(Ok(()))
    dma_fence_signal_locked()
      on_signal()
        Job::submit()
          inner.lock()  <-- self-deadlock

Even across different fences, acquiring fence->lock inside inner.lock()
(during both fence.signal() and, when !needs_drop, dropping
job.dependencies -> FenceCallbackRegistration::drop() ->
dma_fence_remove_callback()) inverts the fence->lock -> inner.lock()
ordering taken whenever a fence callback calls into JobQueue, creating an
ABBA deadlock.

> +
> +            // This enables the RunWorker to complete a job that is not =
yet
> +            // in 'running_jobs', in case of a race against the lock.
> +            *jq.last_completed =3D seqno;
> +            drop(jq_locked);
> +
> +            self.check_start_run_worker();
> +            if needs_drop {
> +                self.check_start_drop_worker();
> +            }
> +        })
> +    }

[Severity: Low]
If complete_jobs_up_to_seqno() is called with seqno =3D=3D *jq.last_complet=
ed,
or when no jobs in running_jobs had seqno <=3D the argument, this still
wakes both run_worker and drop_worker (even when drop_list is empty).
Checking seqno <=3D *jq.last_completed and only starting the workers when at
least one job was completed (and clearing job.dependencies once a job is
popped in RunWorker::run()) would avoid the extra workqueue wakeups and
retain fewer allocations while jobs are running.

> +
> +    /// Set the error with which this JobQueue will signal all running j=
obs'
> +    /// fences. (The jobs on the waiting_list will all complete with ECA=
NCELED
> +    /// as their error)
> +    pub fn set_error(mut self: Pin<&mut Self>, error: Error) {
> +        *self.as_mut().project().err =3D error;
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Prevent the RunWorker from moving more jobs to `running_jobs`.
> +        self.parked.store(true, Relaxed);
> +        self.srcu.synchronize();
> +        self.with_inner(|inner| {
> +            let mut inner_locked =3D inner.lock();
> +            let drop_list =3D core::mem::take(&mut inner_locked.drop_lis=
t);
> +            let waiting_jobs =3D core::mem::take(&mut inner_locked.waiti=
ng_jobs);
> +            let mut running_jobs =3D core::mem::take(&mut inner_locked.r=
unning_jobs);
> +
> +            drop(inner_locked);
> +
> +            while let Some(job) =3D running_jobs.pop_front() {
> +                let fence =3D job.fence.as_ref().expect("fence not prese=
nt");
> +                fence.signal(Err(self.err));
> +            }
> +
> +            drop(drop_list);
> +            drop(waiting_jobs);
> +            drop(running_jobs);
> +        })
> +    }
> +}

[Severity: Medium]
Does JobQueue::drop() leave waiting_jobs unsignaled and wait for a
separate RCU grace period on every job?

Job::submit() already creates a DriverFence for each job in waiting_jobs,
and the doc comments state that dropping a JobQueue signals waiting jobs'
fences with ECANCELED.  Because JobQueue::drop() drops waiting_jobs
without calling fence.signal(Err(ECANCELED)), each waiting job hits
DriverFence::drop()'s unsignaled error path, logging
pr_err!("DriverFence drops unsignaled. Danger of memory corruption!\n")
and calling an unconditional synchronize_rcu().

In addition, while let Some(job) =3D running_jobs.pop_front() drops each job
at the end of the loop body right after fence.signal(Err(self.err)), which
calls cond_synchronize_rcu() immediately per job instead of signaling all
running and waiting fences first so they can share a single grace period.

[1] https://lore.kernel.org/r/kw-1794059738.215694434-299782-0@younes.io

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124122951.8781=
99-2-phasta@kernel.org?part=3D9
