Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49333606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U32abfIU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D1B10E3A8;
	Tue,  3 Nov 2026 16:08:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8E310E3A8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:08:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E35386021D;
 Tue,  3 Nov 2026 16:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E11F000C1;
 Tue,  3 Nov 2026 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793722128;
 bh=ZQj2u0NkRShfdtjl7wLWi4kTR5O82TwiSt1qyU8+pcM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U32abfIUGmFJk2JCc9ndOk3Osd3APQBVlnu5++hpY0pnRsvVcvHWFnwFSku3zz54s
 hPDy2bpq4L1yDyZ8dbN+TOrtICt/kJiNw1jUAccf2C0Uj6ZYrrlDqZvuGJkeRx3uj5
 yXf3pSIj0PqGPnGcqLdGynVoqTPCePO0vdj4CYhje3t5jG3GM9OOyIc9lkxmhM09/L
 Ar1Fi+nMV5dsKMymg0JMI70SDUrZIVj2ftcU7X5MP8nwn8VIaqYprSVOZAbl1u99PY
 F1hNnf0O+rG0wknSdU5BvOaWugY9pgZlrkYHyOoiBkcz0bRPwp5H/Z0r4TkuH3gmxs
 0IYpgeO/qO2BA==
Message-ID: <sashiko-outbox-195701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 7/8] rust: drm: Add JobQueue
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261103153138.1087330-9-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
 <20261103153138.1087330-9-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:08:47 +0000
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

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [High] drm: job_queue: sleeping synchronize_srcu() in DependencyWaker::on=
_signal()
- [High] drm: job_queue: jobs with failed dependencies run in SubmitWorker:=
:run()
- [High] drm: job_queue: ignored fence error status in Job::add_dependency()
- [High] drm: job_queue: premature completion of seqno 0 job in SubmitWorke=
r::run()
- [High] drm: job_queue: leaked capacity and unscheduled drop in SubmitWork=
er::run()
- [High] dma_buf: dma_fence: payload destructor skipped in DriverFence::dro=
p()
- [High] rust: drm: job_queue: unsignaled waiting_jobs in teardown() and dr=
op()
- [High] rust: drm: job_queue: fence signaling and job drop under SpinLockI=
rq
- [High] rust: drm: job_queue: oversized job cost permanently wedges FIFO q=
ueue
- [High] rust: drm: job_queue: aliasing &JobQueue in DependencyWaker during=
 drop()
- [Medium] drm: job_queue: uncallable self receiver and missed jobs in tear=
down()
- [Medium] rust: drm: job_queue: signed i64 cast of u64 capacity in SubmitW=
orker::run()
- [Low] rust: drm: job_queue: commit message mismatch, doc links, and impor=
t style
--

commit ea9affc66eb6042754d0207989d4a309d484ecc8
Author: Philipp Stanner <phasta@kernel.org>

rust: drm: Add JobQueue

This commit adds the JobQueue component in rust/kernel/drm/job_queue.rs to
manage job dependencies, credit-based submission, and dma_fence lifetimes
for GPUs with firmware scheduling.

>     rust: drm: Add JobQueue
>    =20
>     JobQueue is a pure Rust component that handles job submissions for GP=
Us
>     with firmware scheduling, i.e., GPUs that support one exclusive ring =
per
>     execution context.
>    =20
>     JobQueue's primary task is dependency handling, where the user can set
>     dependencies, each in the form of a `dma_buf::Fence`, on a job and th=
en
>     submit it to the queue.
>    =20
>     Jobs are being executed in order, following the FIFO principle. Only
>     jobs whose dependencies are all fulfilled get executed, otherwise the
>     JobQueue pauses.
>    =20
>     A core design principle, just like with DmaFence, is to avoid all
>     allocations in job submission paths, since this runs danger of
>     deadlocking.
>    =20
>     Another design principle, new when compared to the older drafts, is t=
he
>     ownership relationship with fences:
>    =20
>       1. The JobQueue owns the FenceContext exclusively.
>       2. Jobs are created on the JobQueue, ensuring correct fence sequence
>          number ordering.
>       3. Jobs own the respective DriverFence.
>       4. Jobs are owned by the JobQueue.
>    =20
>     Consequently, a driver can only interact with fences and FenceContext
>     indirectly through the JobQueue, and can also only complete jobs (and,
>     hence, signal fences) through the JobQueue.
>    =20
>     Unfortunately, since jobs need a reference to the JobQueue for their
>     fence dependency objects (DependencyWaker), this code can currently n=
ot
>     be used in this form because some work on self-referential PinInit is
>     required. See the respective comments in the Example.
>    =20
>     When a job shall be run, both its JobQueue::data and Job::data get
>     borrowed back to it, together with the sequence number of this job, so
>     that the driver can perform the appropriate interaction with the
>     hardware.
>    =20
>     The submit_worker runs all ready jobs based on a credit count system,=
 so
>     that run_job() can be infallible. The same worker drops jobs (and the=
ir
>     fences) that are already completed. Should this proof to be a
>     performance issue, a second worker could trivially be added for this.
>    =20
>     Signed-off-by: Philipp Stanner <phasta@kernel.org>
>     Co-developed-by: Gary Guo <gary@garyguo.net>
>    =20
>     (^ waiting for Gary to sign-off)

[Severity: Low]
This isn't a bug, but does the commit message still match the current
implementation in rust/kernel/drm/job_queue.rs?

The commit message states that submit_worker drops completed jobs and that a
second worker could be added later, whereas the patch already implements and
uses a separate DropWorker (drop_worker). It also mentions that the code
cannot be used yet due to self-referential PinInit work and refers to
comments in the Example that are no longer present, and it still has the
placeholder note waiting for Gary Guo's sign-off.

In addition, in rust/kernel/drm/job_queue.rs:
- The module doc comment links to JobQueueOps::complete_jobs_up_to_seqno(),
  which is a method on JobQueue rather than JobQueueOps, as well as
  dma_buf::FenceContext, dma_buf::DriverFence, dma_buf::Fence, and
  rcu::synchronize_rcu() without dma_buf or rcu in scope.
- In struct JobQueueInner, a duplicate doc comment for last_completed
  ("Fence sequence number of the last job the user has completed.") is
  attached to waiting_jobs.
- The kernel::sync imports are split across three separate sync:: blocks
  instead of using the kernel vertical import style.

> diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
> new file mode 100644
> index 0000000000000..e51adedaeddbf
> --- /dev/null
> +++ b/rust/kernel/drm/job_queue.rs
[ ... ]
> @@ -142,29 +142,115 @@ struct DependencyWaker<'b, 'nr_of_deps, T: JobQueu=
eOps + Send + Sync> {
>      nr_of_deps: &'nr_of_deps Atomic<u32>,
>      jq: &'b JobQueue<T>,
>  }
> =20
>  impl<'b, T: JobQueueOps + Send + Sync> FenceCallback for DependencyWaker=
<'b, '_, T> {
>      fn on_signal(&mut self, res: Result) {
>          if let Err(err) =3D res {
>              // Dependencies are unfulfilled and will never be fulfilled.=
 Halt the
>              // submit_worker and tell the driver to tear this JQ down.
>              self.jq.revoked.store(true, Relaxed);
>              self.jq.srcu.synchronize();
> =20
>              // TODO RFC:
>              // We likely want a work_item for this, don't we? Because the
>              // dma_fence backend is holding the lock.
>              T::kill(self.jq.fctx.deref(), self.jq.id(), err);
>          }

[Severity: High]
Does calling self.jq.srcu.synchronize() in DependencyWaker::on_signal()
sleep in atomic context?

FenceCallback::on_signal() is invoked from
FenceCallbackRegistration::dma_fence_callback() during C
dma_fence_signal_locked() while holding the fence spinlock with interrupts
disabled, and potentially from hardware interrupt context.

When a dependency fence is signaled with Err(err), self.jq.srcu.synchronize=
()
calls bindings::synchronize_srcu() in Srcu::synchronize()
(rust/kernel/sync/srcu.rs), which sleeps waiting for an SRCU grace period to
complete. If SubmitWorker::run() or DropWorker::run() is currently holding
work.srcu.read_lock() (for example on the same CPU or while dropping a job),
won't this also deadlock waiting for the active SRCU read-side critical
section?

> =20
>          // Last dependency kicks the worker.
>          if self.nr_of_deps.fetch_sub(1, Relaxed) =3D=3D 1 {
>              // The drop-order of JobQueue ensures that all DependencyWak=
ers are
>              // cancelled before the JobQueue itself is dropped.
>              self.jq.check_start_submit_worker();
>          }
>      }
>  }

[Severity: High]
When res is Err(err) in DependencyWaker::on_signal(), execution falls throu=
gh
to decrement self.nr_of_deps and call self.jq.check_start_submit_worker().
Can this cause a job with a failed dependency to still be executed by
SubmitWorker::run()?

In SubmitWorker::run(), work.revoked.load(Relaxed) is only checked once
before entering the waiting_jobs loop:

    let _lock_guard =3D work.srcu.read_lock();
    if work.revoked.load(Relaxed) {
        return;
    }

    let mut jq =3D work.inner.lock();

    while let Some(job) =3D jq.as_mut().project().waiting_jobs.pop_front() {
        if job.nr_of_deps.load(Relaxed) > 0 {
            jq.waiting_jobs.push_front(job);
            break;
        }
        ...
        drop(jq); // Release lock.
        T::run_job(work.fctx, runnable_job);
        jq =3D work.inner.lock(); // Retake lock.

If SubmitWorker::run() is currently unlocked inside T::run_job() for an
earlier job when a subsequent job's dependency signals Err(err),
DependencyWaker::on_signal() decrements that job's nr_of_deps to 0. On the
next loop iteration, SubmitWorker::run() does not re-check work.revoked, se=
es
nr_of_deps =3D=3D 0, and dispatches the job to T::run_job() despite its fai=
led
dependency.

Also, because DependencyWaker::on_signal() does not check whether
self.jq.revoked was already set before calling T::kill(), can T::kill() be
invoked multiple times if multiple dependencies fail, while DropWorker::run=
()
exits early on work.revoked and leaves already-completed jobs in drop_list
undropped?

> =20
>  /// A JobQueue job before it has been submitted.
>  ///
>  /// This is only useful for registering dependencies on and for submitti=
ng it.
>  pub struct Job<'a, T: JobQueueOps + Send + Sync> {
>      inner: Pin<UniqueArc<JobInternal<'a, T>>>,
>      fence_allocation: DriverFenceAllocation<'a, DriverDataWrapper<T>>,
>  }
> =20
>  impl<'a, T: JobQueueOps + Send + Sync> Job<'a, T> {
>      /// Add a dependency for the job.
>      ///
>      /// A JobQueue will only push a job once `fence` has been signaled.
>      pub fn add_dependency(&mut self, fence: &Fence) -> Result {
>          self.inner.as_mut().with_project(|job| {
>              // If the registration below gets registered successfully, a=
 signaling
>              // fence will decrement the atomic. That could race. Thus, i=
ncrement in
>              // advance. Ordering is ensured thanks to the dma_fence back=
end.
>              job.nr_of_deps.fetch_add(1, Relaxed);
> =20
>              let dependency =3D try_pin_init!(Dependency {
>                  links <- ListLinks::new(),
>                  // SAFETY: The `registration` is not forgotten. It drops=
 with JobQueue.
>                  registration <- unsafe {
>                      FenceCallbackRegistration::new(
>                          fence,
>                          DependencyWaker {
>                              nr_of_deps: job.nr_of_deps,
>                              jq: job.jq,
>                          },
>                      )
>                  }
>              });
>              match UniqueArc::pin_init(dependency, GFP_KERNEL) {
>                  Err(e) =3D> {
>                      let _ =3D job.nr_of_deps.fetch_sub(1, Relaxed);
>                      if e =3D=3D ENOENT {
>                          // Was already signaled. No reason to bother the=
 caller.
>                          return Ok(());
>                      }
>                      return Err(e);
>                  }

[Severity: High]
If a dependency fence has already been signaled with an error before
Job::add_dependency() is called, does this ENOENT branch silently ignore the
fence error?

In C dma_fence_add_callback(), -ENOENT is returned whenever
DMA_FENCE_FLAG_SIGNALED_BIT is set, even if fence->error is non-zero. Since
Job::add_dependency() returns Ok(()) on ENOENT without checking
fence.status(), won't a pre-signaled errored dependency fence allow the job
to run as if all dependencies succeeded?

>                  Ok(dep) =3D> {
>                      job.dependencies.push_back(dep);
>                  }
>              }
> =20
>              Ok(())
>          })
>      }
> =20
>      /// Submit the job.
>      ///
>      /// Returns a [`dma_buf::Fence`] on which the user can register call=
backs.
>      /// The fence will be signaled once the job is completed through
>      /// [`JobQueue::complete_jobs_up_to_seqno`], which can happen immedi=
ately
>      /// after the job has been submitted.
>      ///
>      /// This function does all fence initialization under the JobQueue l=
ock in
>      /// one go, including setting of the fence sequence number. Thus, it=
 is
>      /// typically unnecessary (and advaised against) to call this functi=
on with
>      /// a driver lock held.
>      pub fn submit(self) -> ARef<Fence> {
>          let jq =3D self.inner.jq;
>          jq.with_inner(|inner| {
>              // SAFETY: this is a lifetime transmute from `Job<'queue, T>=
` to
>              // `Job<'fctx, T>`.
>              //
>              // `job` internally holds a reference to `JobQueue`, while w=
e are
>              // now moving `job` into `inner`, which may borrow from `fct=
x` but
>              // not the full `JobQueue`. So on surface this would be inco=
rrect.
>              // However, as we drain `inner` inside `JobQueue::drop`, the
>              // reference is gone before any field is destructed.
>              let mut job =3D unsafe { core::mem::transmute::<Job<'_, T>, =
Job<'_, T>>(self) };

[Severity: High]
Does erasing the borrow lifetime of self.inner.jq in Job::submit() create
aliasing between &JobQueue<T> in DependencyWaker::on_signal() and
Pin<&mut JobQueue<T>> in <JobQueue<T> as PinnedDrop>::drop()?

After Job::submit() transmutes the lifetime of Job<'_, T>, the caller can
drop JobQueue<T> while DependencyWaker callbacks in waiting_jobs are still
registered on external dma_fences:

    impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<T> {
        fn drop(self: Pin<&mut Self>) {
            self.revoked.store(true, Relaxed);
            self.srcu.synchronize();
            self.with_inner(|inner| {
                let mut inner =3D inner.lock();
                let waiting_jobs =3D core::mem::take(&mut inner.waiting_job=
s);
                ...
                drop(waiting_jobs);

Because DependencyWaker::on_signal() neither enters an SRCU read-side
critical section on self.jq.srcu nor checks self.jq.revoked before accessing
self.jq, a dependency fence signaling on another CPU before
drop(waiting_jobs) completes will dereference self.jq: &JobQueue<T>
concurrently while PinnedDrop::drop() holds an exclusive Pin<&mut Self>
reference.

[ ... ]
> @@ -303,75 +303,75 @@ impl<T: JobQueueOps + Send + Sync> ScopedWorkItem f=
or SubmitWorker<'_, '_, T> {
>      fn run(work: &ScopedWorkRef<Self>) {
>          // Synchronize against revocation in `JobQueue::drop`.
>          let _lock_guard =3D work.srcu.read_lock();
>          if work.revoked.load(Relaxed) {
>              return;
>          }
> =20
>          let mut jq =3D work.inner.lock();
> =20
>          while let Some(job) =3D jq.as_mut().project().waiting_jobs.pop_f=
ront() {
>              // While we didn't hold the lock below for `run_job()`, it c=
ould be
>              // that a new job entered the waiting list which has an unfu=
lfilled
>              // dependency.
>              if job.nr_of_deps.load(Relaxed) > 0 {
>                  jq.waiting_jobs.push_front(job);
>                  break;
>              }
>              let new_capacity =3D jq.capacity as i64 - i64::from(job.cost=
);
>              if new_capacity < 0 {
>                  jq.waiting_jobs.push_front(job);
>                  break;
>              }
>              *jq.as_mut().project().capacity =3D new_capacity as u64;

[Severity: Medium]
In SubmitWorker::run(), if JobQueue::new() is called with a capacity greater
than i64::MAX as u64, won't casting jq.capacity from u64 to i64 wrap into a
negative number (or overflow i64::MIN when subtracting job.cost) and stall
the queue? Would jq.capacity.checked_sub(u64::from(job.cost)) avoid the
signed cast?

> =20
>              let fence =3D job.fence.as_ref().expect("fence not present");
>              let seqno =3D fence.as_fence().seqno();
>              let runnable_job =3D JobRunnable {
>                  seqno,
>                  data: fence.deref(),
>              };
> =20
>              drop(jq); // Release lock.
>              T::run_job(work.fctx, runnable_job);
>              jq =3D work.inner.lock(); // Retake lock.
> =20
>              // run_job() above needs to be called without lock protectio=
n. Thus,
>              // it is possible that the driver instructed completion righ=
t before
>              // we could re-take the lock.
>              if jq.last_completed >=3D seqno {
>                  fence.signal(Ok(()));
> =20
>                  // Drop here directly if possible. Otherwise, let the Dr=
opWorker
>                  // take care of it.
>                  if core::mem::needs_drop::<T::JobDataType>() {
>                      jq.drop_list.push_back(job);
>                  }
>              } else {
>                  jq.running_jobs.push_back(job);
>              }
>          }
>      }
>  }

[Severity: High]
As reported by Sashiko on RFC v6 [1], when a job completes in
JobQueue::complete_jobs_up_to_seqno() before SubmitWorker::run() re-acquires
work.inner.lock() after T::run_job(), doesn't the if jq.last_completed >=3D=
 seqno
branch leak job.cost from jq.capacity and fail to schedule drop_worker?

Before releasing work.inner.lock() to call T::run_job(), SubmitWorker::run()
subtracts job.cost from jq.capacity while the job is not in jq.running_jobs.
If JobQueue::complete_jobs_up_to_seqno() runs during that window, it does n=
ot
find the job in jq.running_jobs, so it only updates *jq.last_completed =3D =
seqno
without restoring job.cost to jq.capacity.

When SubmitWorker::run() retakes work.inner.lock() and enters
if jq.last_completed >=3D seqno, it signals the fence and pushes the job to
jq.drop_list without adding u64::from(job.cost) back to jq.capacity and
without kicking drop_worker.

> =20
>  struct DropWorker<'a, 'fctx, T: JobQueueOps + Send + Sync> {
>      srcu: &'a Srcu,
>      revoked: &'a AtomicFlag,
>      inner: &'a SpinLockIrq<JobQueueInner<'fctx, T>>,
>  }
> =20
>  impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, '_,=
 T> {
>      fn run(work: &ScopedWorkRef<Self>) {
>          // Synchronize against revocation in `JobQueue::drop`.
>          let _lock_guard =3D work.srcu.read_lock();
>          if work.revoked.load(Relaxed) {
>              return;
>          }
> =20
>          let mut jq_locked =3D work.inner.lock();
> =20
>          while let Some(job) =3D jq_locked.drop_list.pop_front() {
>              drop(jq_locked);
>              drop(job);
>              jq_locked =3D work.inner.lock();
>          }
>      }
>  }

[Severity: High]
When DropWorker::run() (or JobQueue::drop()) drops a completed job whose
T::JobDataType implements Drop, is the destructor of T::JobDataType actually
executed by DriverFence::drop()?

In rust/kernel/dma_buf/dma_fence.rs, DriverFence<'a, T> stores self.data as
NonNull<DriverFenceData<'a, T>>, and DriverFence::drop() does:

    // SAFETY: Valid because `self` is valid.
    unsafe { drop_in_place(&raw mut self.data) };

    // SAFETY: The `synchronize_rcu()` above ensures all accessors are gone.
    unsafe { bindings::dma_fence_put(self.as_raw()) };

Because self.data is a NonNull pointer rather than the payload itself,
drop_in_place(&raw mut self.data) is a no-op and never runs the destructor =
of
(*self.data.as_ptr()).data (which holds T::JobDataType) before dma_fence_pu=
t()
frees the underlying allocation.

[ ... ]
> @@ -620,72 +620,148 @@ impl<T: JobQueueOps + Send + Sync> JobQueue<T> {
>      /// Create a new JobQueue.
>      pub fn new<E>(
>          initial_seqno: u64,
>          // TODO: pass these as &CStr. Figure out how to get the lifetime=
s for PinInit right.
>          driver_name: CString,
>          timeline_name: CString,
>          capacity: u64,
>          data: impl PinInit<T, E>,
>      ) -> impl PinInit<Self, Error>
>      where
>          Error: From<E>,
>          E: From<Infallible>,
>      {
>          try_pin_init!(Self {
>              srcu <- new_srcu!(),
>              revoked: AtomicFlag::new(false),
>              fctx <- FenceContext::new(initial_seqno, &driver_name, &time=
line_name,
>                                        DriverDataWrapper::new(data)),
>              inner <- new_spinlock_irq!(try_pin_init!(JobQueueInner {
>                  capacity,
>                  last_completed: 0,
>                  waiting_jobs: UniqueList::new(),
>                  running_jobs: UniqueList::new(),
>                  drop_list: UniqueList::new(),
>              })),

[Severity: High]
If JobQueue::new() is called with initial_seqno =3D=3D 0 (as in the doctest
example), won't initializing last_completed: 0 cause SubmitWorker::run() to
treat the very first job (which receives seqno =3D=3D 0 from
FenceContext::next_seqno()) as already completed immediately after
T::run_job() returns?

In SubmitWorker::run():

    if jq.last_completed >=3D seqno {
        fence.signal(Ok(()));

        if core::mem::needs_drop::<T::JobDataType>() {
            jq.drop_list.push_back(job);
        }
    } else {
        jq.running_jobs.push_back(job);
    }

When initial_seqno is 0, jq.last_completed >=3D seqno evaluates 0 >=3D 0 as=
 true
for the first job before complete_jobs_up_to_seqno() has ever been called,
prematurely signaling its fence, dropping the job while it is still running
on hardware, and leaking its capacity credits.

[ ... ]
>      /// Create a new job.
>      ///
>      /// The `cost` specified here is what JobQueue subtracts from its ca=
pacity
>      /// to determine whether a job is runnable, i.e., has space on the G=
PU ring.
>      ///
>      /// The `data` contained by a job will be borrowed back to the drive=
r once
>      /// the jobs shall be run through [`JobQueueOps::run_job`].
>      pub fn new_job<'a>(&'a self, cost: u32, data: T::JobDataType) -> Res=
ult<Job<'a, T>> {
>          let fence_allocation =3D self.fctx.new_fence_allocation(data)?;
>          let job =3D try_pin_init!(JobInternal {
>              links <- ListLinks::new(),
>              cost,
>              fence: None,
>              nr_of_deps: Atomic::new(0),
>              dependencies: UniqueList::new(),
>              jq: &self,
>          });

[Severity: High]
As reported by Sashiko on RFC v6 [2], if a job is created in
JobQueue::new_job() with a cost greater than the queue's total initial
capacity and then submitted, won't SubmitWorker::run() permanently wedge the
FIFO queue?

Because JobQueue::new_job() does not reject cost values exceeding the maxim=
um
queue capacity, SubmitWorker::run() will always seejq.capacity < job.cost
even after all running jobs complete, pushing the oversized job back to the
front of waiting_jobs and blocking all subsequent jobs in the queue.

[ ... ]
>      pub fn complete_jobs_up_to_seqno(&self, seqno: u64) {
>          self.with_inner(|inner| {
>              let needs_drop =3D core::mem::needs_drop::<T::JobDataType>();
>              let mut jq_locked =3D inner.lock();
>              let mut jq =3D jq_locked.as_mut().project();
> =20
>              if seqno < *jq.last_completed {
>                  return;
>              }
> =20
>              while let Some(mut job) =3D jq.running_jobs.pop_front() {
>                  if job
>                      .as_mut()
>                      .project()
>                      .fence
>                      .as_mut()
>                      .expect("fence not present")
>                      .as_fence()
>                      .seqno()
>                      > seqno
>                  {
>                      jq.running_jobs.push_front(job);
>                      break;
>                  }
> =20
>                  *jq.capacity +=3D u64::from(job.cost);
> =20
>                  let fence =3D job.fence.as_ref().expect("fence not prese=
nt");
>                  fence.signal(Ok(()));
> =20
>                  if needs_drop {
>                      jq.drop_list.push_back(job);
>                  }
>                  // Otherwise, job is dropped here directly. Its fence wo=
n't perform
>                  // an RCU grace period wait.
>              }

[Severity: High]
Can calling fence.signal() and dropping job while holding inner.lock()
(SpinLockIrq) in JobQueue::complete_jobs_up_to_seqno() (as well as in
SubmitWorker::run() and JobQueue::teardown()) deadlock?

DriverFence::signal() acquires the fence spinlock and synchronously invokes
all registered FenceCallback::on_signal() callbacks while inner.lock() is
held. If a callback on that fence submits a job via Job::submit() or calls
complete_jobs_up_to_seqno() on the same JobQueue, it will attempt to acquire
inner.lock() on the same CPU and deadlock.

Furthermore, when !needs_drop, dropping job at the end of the loop while
holding inner.lock() drops job.dependencies, which calls
FenceCallbackRegistration::drop() -> bindings::dma_fence_remove_callback()
and acquires each dependency fence's spinlock under inner.lock() (lock order
inner.lock() -> fence->lock). Meanwhile, DependencyWaker::on_signal() runs
under fence->lock, and any fence callback that takes inner.lock() establish=
es
the opposite lock order (fence->lock -> inner.lock()), creating an AB-BA
deadlock.

[ ... ]
> @@ -785,42 +785,42 @@ impl<T: JobQueueOps + Send + Sync> JobQueue<T> {
>      pub fn teardown<E>(self, error: Error)
>      where
>          Error: From<E>,
>      {
>          self.with_inner(|inner| {
>              let mut jq =3D inner.lock();
> =20
>              // We don't drop the jobs and fences here while we hold the =
lock. Just
>              // signal with the error. The dropping lists will then drop =
them locklessly.
> =20
>              while let Some(job) =3D jq.running_jobs.pop_front() {
>                  let fence =3D job.fence.as_ref().expect("fence not prese=
nt");
>                  fence.signal(Err(error));
> =20
>                  jq.drop_list.push_back(job);
>              }
>          })
>      }
>  }

[Severity: Medium]
As reported by Sashiko on RFC v6 [3], how can a caller invoke
JobQueue::teardown() when JobQueue<T> is #[pin_data(PinnedDrop)] (!Unpin) a=
nd
teardown<E>(self, error: Error) takes self by value with an unconstrained
type parameter E?

Because JobQueue<T> is pin-initialized (for example via KBox::pin_init), it
cannot be moved out of a Pin pointer by value, and E cannot be inferred from
the arguments since error has type Error rather than E. In addition,
teardown() only drains and signals jq.running_jobs while leaving
jq.waiting_jobs untouched.

> =20
>  #[pinned_drop]
>  impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<T> {
>      fn drop(self: Pin<&mut Self>) {
>          // Revoke to prevent still existing DependencyWakers from kickin=
g the
>          // SubmitWorker again before we could deregister them.
>          self.revoked.store(true, Relaxed);
>          self.srcu.synchronize();
>          self.with_inner(|inner| {
>              let mut inner =3D inner.lock();
>              let waiting_jobs =3D core::mem::take(&mut inner.waiting_jobs=
);
>              let running_jobs =3D core::mem::take(&mut inner.running_jobs=
);
>              let drop_list =3D core::mem::take(&mut inner.drop_list);
>              drop(inner);
>              drop(waiting_jobs);
>              drop(running_jobs);
>              drop(drop_list);
>          })
>      }
>  }

[Severity: High]
As reported by Sashiko on RFC v6 [4], when JobQueue::teardown() or
<JobQueue<T> as PinnedDrop>::drop() runs, aren't jobs in waiting_jobs (and
running_jobs on normal drop) dropped without signaling their fences first?

JobQueue::teardown() does not set self.revoked or signal fences in
jq.waiting_jobs with Err(error), and <JobQueue<T> as PinnedDrop>::drop()
drops waiting_jobs and running_jobs directly without signaling their
DriverFences with ECANCELED. As a result, dropping those jobs hits the
unsignaled fallback in DriverFence::drop(), which logs an error ("DriverFen=
ce
drops unsignaled. Danger of memory corruption!") and signals waiting_jobs w=
ith
ECANCELED instead of the error passed to teardown().

[1] https://lore.kernel.org/r/20261016085724.1031766-7-phasta@kernel.org
[2] https://lore.kernel.org/r/20261016085724.1031766-7-phasta@kernel.org
[3] https://lore.kernel.org/r/20261016085724.1031766-7-phasta@kernel.org
[4] https://lore.kernel.org/r/20261016085724.1031766-7-phasta@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103153138.1087=
330-2-phasta@kernel.org?part=3D7
