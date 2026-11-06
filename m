Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C030606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXGwNbC8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DE610EA5C;
	Fri,  6 Nov 2026 14:46:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CE110EA5C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEB3241324;
 Fri,  6 Nov 2026 14:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F571F008A2;
 Fri,  6 Nov 2026 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793976366;
 bh=7UKlZu2OhC+oOMfHxWlm4ZlFIxCLl2huu0n4O0moKTw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BXGwNbC89qjnKmpB45QRDlq59rf+Z4XAxK+XF+yUya6U4yQdepUH/pOsT9oXGR3LX
 gcxXaYTfkIVuEvGm30pZfQS1N+RUcAjKmq1XmuyzV6LGvszC96N/+DvRlyyQ05+pkS
 ddnbJ/qX7LSzR0rrUN79++BXAXFhWPs1XmzXDjzTlrLLQx9eXoXikLpO8ftep6hfhb
 uqVgxnKtl9kAwPAOlU//MPke+w76imUMreHxd0EKOxuMBCFB07afvziKaOhxUVz1sJ
 fu6QkiCQMI040c97ilEAWA7PRWgoj5w0spl4+X5G8zV5egKCAW9n7cK3fmOJ8vekzb
 aTg1mw4MVEzkg==
Message-ID: <sashiko-outbox-201603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] rust: drm: Add JobQueue
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261106140752.520386-9-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
 <20261106140752.520386-9-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:46:05 +0000
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

Thank you for your contribution! Sashiko AI review found 13 potential
issues to consider:
- [High] dma_buf: dma_fence: payload destructor skipped in
  DriverFence::drop()
- [High] drm: job_queue: sleeping while atomic in JobQueue::drop() for
  running_jobs
- [High] drm: job_queue: aliasing &JobQueue in DependencyWaker during
  drop()
- [High] drm: job_queue: fence signaling and job drop under inner
  SpinLockIrq
- [High] rust: drm: job_queue: unused ScopedQueues and unsafe system
  workqueue teardown
- [High] rust: drm: job_queue: premature callback registration in
  Job::add_dependency()
- [Medium] drm: job_queue: waiting_jobs dropped unsignaled in
  JobQueue::drop()
- [Medium] drm: job_queue: unscheduled DropWorker in SubmitWorker::run()
  on race
- [Medium] drm: job_queue: JobQueue::set_error() takes &mut self on
  !Unpin type
- [Medium] rust: drm: job_queue: signed i64 cast of u64 capacity in
  SubmitWorker::run()
- [Medium] rust: drm: job_queue: aliasing UB mutably projecting
  JobInternal in Job
- [Medium] rust: drm: missing Release/Acquire ordering on nr_of_deps in
  job_queue
- [Low] rust: drm: job_queue: commit message mismatch, doc links,
  imports, and inline
--

commit b3216e20bdde02360e49223e2056bc836b34d736
Author: Philipp Stanner <phasta@kernel.org>

> rust: drm: Add JobQueue
>=20
> JobQueue is a pure Rust component that handles job submissions for GPUs
> with firmware scheduling, i.e., GPUs that support one exclusive ring per
> execution context.
>=20
> JobQueue's primary task is dependency handling, where the user can set
> dependencies, each in the form of a `dma_buf::Fence`, on a job and then
> submit it to the queue.
>=20
> Jobs are being executed in order, following the FIFO principle. Only
> jobs whose dependencies are all fulfilled get executed, otherwise the
> JobQueue pauses.
>=20
> A core design principle, just like with DmaFence, is to avoid all
> allocations in job submission paths, since this runs danger of
> deadlocking.
>=20
> Another design principle, new when compared to the older drafts, is the
> ownership relationship with fences:
>=20
>   1. The JobQueue owns the FenceContext exclusively.
>   2. Jobs are created on the JobQueue, ensuring correct fence sequence
>      number ordering.
>   3. Jobs own the respective DriverFence.
>   4. Jobs are owned by the JobQueue.
>=20
> Consequently, a driver can only interact with fences and FenceContext
> indirectly through the JobQueue, and can also only complete jobs (and,
> hence, signal fences) through the JobQueue.
>=20
> Unfortunately, since jobs need a reference to the JobQueue for their
> fence dependency objects (DependencyWaker), this code can currently not
> be used in this form because some work on self-referential PinInit is
> required. See the respective comments in the Example.
>=20
> When a job shall be run, both its JobQueue::data and Job::data get
> borrowed back to it, together with the sequence number of this job, so
> that the driver can perform the appropriate interaction with the
> hardware.
>=20
> The submit_worker runs all ready jobs based on a credit count system, so
> that run_job() can be infallible. The same worker drops jobs (and their
> fences) that are already completed. Should this proof to be a
> performance issue, a second worker could trivially be added for this.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Co-developed-by: Gary Guo <gary@garyguo.net>
>=20
> (^ waiting for Gary to sign-off)

[Severity: Low]
This isn't a bug, but the commit message appears to be out of date with the
patch: self-referential PinInit is already used by JobQueue (and the
Example has no comments about it), DropWorker is already implemented as a
separate worker rather than submit_worker dropping completed jobs, and
Co-developed-by: Gary Guo is missing a matching Signed-off-by trailer.

In addition, in rust/kernel/drm/job_queue.rs, the rustdoc links to
JobQueue::submit() (the method is Job::submit()), dma_buf::FenceContext,
dma_buf::DriverFence, dma_buf::Fence, and rcu::synchronize_rcu() do not
resolve because those symbols are not in scope. The kernel::sync imports
are also split across three separate blocks with horizontal formatting
instead of the kernel vertical import style, and the small wrapper and
accessor functions (in UniqueList, DriverDataWrapper, and JobQueue::deref,
JobQueue::id, and JobQueue::set_error) are missing #[inline].

> diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
> new file mode 100644
> index 0000000000000..9ddcdda6e4d18
> --- /dev/null
> +++ b/rust/kernel/drm/job_queue.rs
[ ... ]
> +impl<'b, T: JobQueueOps + Send + Sync> FenceCallback for DependencyWaker=
<'b, '_, T> {
> +    fn on_signal(&mut self, res: Result) {
> +        if let Err(err) =3D res {
> +            T::kill(self.jq.fctx.deref(), self.jq.id(), err);
> +            return;
> +        }
> +
> +        // Last dependency kicks the worker.
> +        if self.nr_of_deps.fetch_sub(1, Relaxed) =3D=3D 1 {
> +            // The drop-order of JobQueue ensures that all DependencyWak=
ers are
> +            // cancelled before the JobQueue itself is dropped.
> +            self.jq.check_start_submit_worker();
> +        }
> +    }
> +}

[Severity: Medium]
Can T::run_job() observe stale memory state from before a dependency fence
was signaled on weakly-ordered architectures because nr_of_deps is updated
and read with Relaxed ordering?

DependencyWaker::on_signal() decrements nr_of_deps with fetch_sub(1,
Relaxed) without taking inner.lock(), and SubmitWorker::run() checks
job.nr_of_deps.load(Relaxed) > 0 before dropping the lock and calling
T::run_job(). The workqueue wakeup in check_start_submit_worker() does not
order this when earlier dependencies of a multi-dependency job decrement
nr_of_deps without waking the worker, or when SubmitWorker::run() is
already running on another CPU:

CPU0                              CPU1
DependencyWaker::on_signal()      SubmitWorker::run()
  // fence payload writes
  nr_of_deps.fetch_sub(1, Relaxed)
                                    job.nr_of_deps.load(Relaxed) =3D=3D 0
                                    drop(jq)
                                    T::run_job()  <-- sees stale memory
  check_start_submit_worker()

Using Release ordering on fetch_sub() in DependencyWaker::on_signal() and
Acquire ordering on load() in SubmitWorker::run() would establish the
needed happens-before relationship.

[ ... ]
> +impl<'a, T: JobQueueOps + Send + Sync> Job<'a, T> {
> +    /// Add a dependency for the job.
> +    ///
> +    /// A JobQueue will only run a job once `fence` has been signaled wi=
th `Ok(())`.
> +    ///
> +    /// This action can race with the fence being signaled. The returned=
 Result
> +    /// indicates success, obviously. Should an error be returned, this =
means
> +    /// that the dependency fence signaled with an error, meaning the as=
sociated
> +    /// action will not be completed. It is then up to the caller to dec=
ide
> +    /// whether it can continue operating on this [`JobQueue`].
> +    pub fn add_dependency(&mut self, fence: &Fence) -> Result {
> +        self.inner.as_mut().with_project(|job| {
> +            // If the registration below gets registered successfully, a=
 signaling
> +            // fence will decrement the atomic. That could race. Thus, i=
ncrement in
> +            // advance. Ordering is ensured thanks to the dma_fence back=
end.
> +            job.nr_of_deps.fetch_add(1, Relaxed);
> +
> +            let dependency =3D try_pin_init!(Dependency {
> +                links <- ListLinks::new(),
> +                // SAFETY: The `registration` is not forgotten. It drops=
 with JobQueue.
> +                registration <- unsafe {
> +                    FenceCallbackRegistration::new(
> +                        fence,
> +                        DependencyWaker {
> +                            nr_of_deps: job.nr_of_deps,
> +                            jq: job.jq,
> +                        },
> +                    )
> +                }
> +            });

[Severity: High]
Does registering DependencyWaker in Job::add_dependency() before
Job::submit() allow an unsubmitted job to kill the JobQueue or cause a
use-after-free if the Job is forgotten?

Because FenceCallbackRegistration::new() arms the callback immediately, if
a first dependency fence signals an error while the caller is still adding
dependencies (for example, when a second add_dependency() fails and the
caller aborts the job), DependencyWaker::on_signal() invokes T::kill() and
tears down the JobQueue for a job that was never submitted. In addition,
JobQueue does not take ownership of Job until Job::submit(), so safe code
calling core::mem::forget(job) after add_dependency() leaks the callback
registration on the C dma_fence and causes DependencyWaker::on_signal() to
dereference a dangling self.jq pointer if the fence signals after JobQueue
is dropped.

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

[Severity: High]
Does erasing the &'b JobQueue<T> lifetime in Job::submit() create aliasing
undefined behavior when JobQueue::set_error() or PinnedDrop::drop() takes
an exclusive mutable reference to JobQueue<T>?

Each JobInternal and registered DependencyWaker holds a shared reference
&JobQueue<T>. Transmuting the lifetime in Job::submit() allows the owner to
call JobQueue::set_error(&mut self) or PinnedDrop::drop(self: Pin<&mut
Self>) while DependencyWaker callbacks in waiting_jobs remain registered on
external fences. Until waiting_jobs is dropped at the end of
PinnedDrop::drop(), a dependency fence signaling on another CPU runs
DependencyWaker::on_signal() and dereferences &JobQueue<T> concurrently
with Pin<&mut JobQueue<T>> (and without checking self.jq.revoked or taking
self.jq.srcu.read_lock()).

> +
> +            // The lock orders setting of the sequence number, so no dri=
ver lock is needed.
> +            let mut inner =3D inner.lock();
> +            let fence =3D job.fence_allocation.new_fence();
> +            let ret_fence =3D ARef::from(fence.as_fence());
> +
> +            *job.inner.as_mut().project().fence =3D Some(fence);

[Severity: Medium]
Does calling job.inner.as_mut().project() in Job::submit() (and
self.inner.as_mut().with_project() in subsequent Job::add_dependency()
calls) create an exclusive &mut JobInternal that aliases the &Atomic<u32>
held by already-registered DependencyWaker callbacks?

Once Job::add_dependency() registers a DependencyWaker holding nr_of_deps:
&Atomic<u32>, the fence can signal on another CPU at any time and read
self.nr_of_deps in DependencyWaker::on_signal(). Calling
Pin::<UniqueArc<JobInternal>>::as_mut() invokes UniqueArc::deref_mut(),
producing an exclusive &mut JobInternal (and &mut Atomic<u32>) while that
shared reference is live and concurrently accessed.

[ ... ]
> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for SubmitWorker<'_, '=
_, T> {
> +    fn run(work: &ScopedWorkRef<Self>) {
[ ... ]
> +            let new_capacity =3D jq.capacity as i64 - i64::from(job.cost=
);
> +            if new_capacity < 0 {
> +                jq.waiting_jobs.push_front(job);
> +                break;
> +            }
> +            *jq.as_mut().project().capacity =3D new_capacity as u64;

[Severity: Medium]
Can casting jq.capacity to i64 in SubmitWorker::run() stall the queue or
underflow when capacity_param exceeds i64::MAX as u64?

JobQueue::new() accepts capacity_param: u64, so a capacity above i64::MAX
becomes negative when cast to i64, causing new_capacity < 0 to always hold
(or underflowing i64::MIN when subtracting job.cost). Using
jq.capacity.checked_sub(u64::from(job.cost)) avoids the signed conversion.

[ ... ]
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

[Severity: Medium]
Does pushing job onto jq.drop_list here without scheduling drop_worker
leave the completed job stranded when complete_jobs_up_to_seqno() wins the
race during T::run_job()?

CPU0 (SubmitWorker::run)          CPU1 (IRQ / complete_jobs_up_to_seqno)
drop(jq)
T::run_job(...)
                                  inner.lock()
                                  // job is not in running_jobs yet
                                  *jq.last_completed =3D seqno
                                  drop(jq_locked)
                                  check_start_drop_worker()
                                    // DropWorker sees empty drop_list
jq =3D work.inner.lock()
if jq.last_completed >=3D seqno {
  jq.drop_list.push_back(job)     <-- drop_worker never scheduled

Until another job completes or the JobQueue is destroyed, the job and its
T::JobDataType payload remain on drop_list without being dropped.

[ ... ]
> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, '_,=
 T> {
> +    fn run(work: &ScopedWorkRef<Self>) {
> +        // Synchronize against revocation in `JobQueue::drop`.
> +        let _lock_guard =3D work.srcu.read_lock();
> +        if work.revoked.load(Relaxed) {
> +            return;
> +        }
> +
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
Does dropping a completed job leak its T::JobDataType payload because
DriverFence::drop() drops the NonNull pointer instead of the pointee data?

In commit "rust: DmaFence: Replace call_rcu() with synchronize_rcu()",
DriverFence::drop() does:

rust/kernel/dma_buf/dma_fence.rs:DriverFence::drop() {
    ...
        // SAFETY: Valid because `self` is valid.
        unsafe { drop_in_place(&raw mut self.data) };

        // SAFETY: The `synchronize_rcu()` above ensures all accessors are =
gone.
        unsafe { bindings::dma_fence_put(self.as_raw()) };
}

Because self.data in DriverFence is NonNull<DriverFenceData<'a, T>>,
drop_in_place(&raw mut self.data) is a no-op on the pointer wrapper rather
than dropping (*self.data.as_ptr()).data, so the destructor for
T::FenceDataType (and T::JobDataType in JobQueue) never runs before
dma_fence_put() frees the allocation.

[ ... ]
> +    fn check_start_submit_worker(&self) {
> +        self.with_submit_worker(|submit_worker| {
> +            // TODO this shouldn't be the system wq
> +            // SAFETY: The worker is carried by the JobQueue and, thus, =
cannot be
> +            // forgotten.
> +            let _ =3D unsafe { workqueue::system_dfl().enqueue_scoped(su=
bmit_worker) };
> +        })
> +    }
> +
> +    fn check_start_drop_worker(&self) {
> +        self.with_drop_worker(|drop_worker| {
> +            // TODO this shouldn't be the system wq
> +            // Use the long-running wq for now, since here all the RCU d=
elays manifest.
> +            // SAFETY: The worker is carried by the JobQueue and, thus, =
cannot be
> +            // forgotten.
> +            let _ =3D unsafe { workqueue::system_long().enqueue_scoped(d=
rop_worker) };
> +        })
> +    }

[Severity: High]
Can enqueuing submit_worker and drop_worker onto system_dfl() and
system_long() instead of submit_queue and drop_queue cause a use-after-free
when JobQueue is dropped?

JobQueue::new() allocates submit_queue and drop_queue (with drop_queue
annotated with 'inner instead of 'drop_worker), but neither queue is ever
used. Because work items are queued on the global system workqueues:

1. In JobQueue::drop(), self.srcu.synchronize() only waits for workers that
   have already entered work.srcu.read_lock(), and dropping submit_queue
   and drop_queue does not cancel or flush work items still pending on
   system_dfl() or system_long().
2. DependencyWaker callbacks in waiting_jobs are not dropped until after
   self.srcu.synchronize() in JobQueue::drop() and do not check
   self.jq.revoked, so a dependency fence signaling during teardown can
   call check_start_submit_worker() and re-enqueue submit_worker onto
   system_dfl() after synchronize() has finished, executing the embedded
   ScopedWork after JobQueue is freed.

In addition, system_dfl() does not set WQ_MEM_RECLAIM even though
submit_worker runs in the dma_fence signaling path.

[ ... ]
> +    pub fn complete_jobs_up_to_seqno(&self, seqno: u64) {
[ ... ]
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
Can calling fence.signal() and dropping jobs while holding inner.lock()
(SpinLockIrq) deadlock in complete_jobs_up_to_seqno() and
SubmitWorker::run()?

fence.signal() synchronously invokes all registered FenceCallback::on_signa=
l()
callbacks while inner.lock() is held with interrupts disabled, so any
callback on the returned fence from Job::submit() that calls Job::submit()
or complete_jobs_up_to_seqno() on the same JobQueue will deadlock trying to
re-acquire inner.lock() on the same CPU.

Furthermore, when !needs_drop, job is dropped at the end of the loop
iteration while still holding inner.lock(), which drops
job.dependencies (FenceCallbackRegistration::drop() ->
dma_fence_remove_callback()) and acquires each dependency fence's spinlock
under inner.lock(), inverting the fence->lock -> inner.lock() lock order:

CPU0                              CPU1
----                              ----
lock(&inner)
                                  lock(&dep_fence->lock)
lock(&dep_fence->lock)
                                  lock(&inner)

 *** DEADLOCK ***

CPU0: complete_jobs_up_to_seqno() -> drop(job) -> dma_fence_remove_callback=
()
CPU1: dma_fence_signal() -> on_signal() -> Job::submit()

[ ... ]
> +    pub fn set_error(&mut self, error: Error) {
> +        self.err =3D error;
> +    }
> +}

[Severity: Medium]
Can JobQueue::set_error() ever be called in safe Rust when JobQueue<T> is
!Unpin?

JobQueue<T> is annotated with #[pin_data(PinnedDrop)] and constructed via
JobQueue::new() -> impl PinInit<Self, Error>, so callers hold a pinned
pointer such as Pin<KBox<JobQueue<T>>>. Because JobQueue<T> is !Unpin,
Pin<Ptr> does not implement DerefMut, making pub fn set_error(&mut self,
error: Error) uncallable without unsafe code. Storing err inside
JobQueueInner under inner: SpinLockIrq (or in an atomic) and taking &self
would allow drivers to set the error before dropping the queue.

> +
> +#[pinned_drop]
> +impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Revoke to prevent still existing DependencyWakers from kickin=
g the
> +        // SubmitWorker again before we could deregister them.
> +        self.revoked.store(true, Relaxed);
> +        self.srcu.synchronize();
> +        self.with_inner(|inner| {
> +            let mut inner =3D inner.lock();
> +            let drop_list =3D core::mem::take(&mut inner.drop_list);
> +            let waiting_jobs =3D core::mem::take(&mut inner.waiting_jobs=
);
> +            let mut running_jobs =3D core::mem::take(&mut inner.running_=
jobs);
> +
> +            while let Some(job) =3D running_jobs.pop_front() {
> +                let fence =3D job.fence.as_ref().expect("fence not prese=
nt");
> +                fence.signal(Err(self.err));
> +            }

[Severity: High]
Does running_jobs.pop_front() in JobQueue::drop() sleep with hardware
interrupts disabled by dropping each job inside the loop while holding
inner.lock()?

Each iteration of while let Some(job) =3D running_jobs.pop_front() takes
ownership of job and drops it at the end of the loop body while inner
(a SpinLockIrq guard) is still held:

JobQueue::drop()
  inner.lock()
  running_jobs.pop_front()
  drop(job)
    DriverFence::drop()
      synchronize_rcu()  <-- sleeps with IRQs disabled and spinlock held

By the time drop(running_jobs) runs after drop(inner), running_jobs is
already empty.

> +
> +            drop(inner);
> +            drop(drop_list);
> +            drop(waiting_jobs);
> +            drop(running_jobs);
> +        })
> +    }
> +}

[Severity: Medium]
Are the fences of jobs in waiting_jobs dropped without being signaled in
JobQueue::drop()?

Job::submit() creates a DriverFence for each job before pushing it onto
waiting_jobs, and the documentation for JobQueue states that dropping a
JobQueue signals all remaining waiting jobs' fences with ECANCELED.
However, JobQueue::drop() only signals running_jobs and drops waiting_jobs
unsignaled, hitting DriverFence::drop()'s unsignaled error path ("DriverFen=
ce
drops unsignaled. Danger of memory corruption!") for every waiting job.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106140752.5203=
86-2-phasta@kernel.org?part=3D7
