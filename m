Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7ABCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB32F1126EC;
	Fri, 16 Oct 2026 09:12:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E051126C2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:12:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABDF1601F0;
 Fri, 16 Oct 2026 09:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B881F000C4;
 Fri, 16 Oct 2026 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141955;
 bh=HlFcr7U+qKhjV6ADczC7LFy0x9iblMpHBQI50ui8PpM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PlIs4HIrDSfgMmqCfoja8pZFKVlXwV56Wi4tLRgI/o61F5WgDqW4UyJ3tl4pMp5EW
 4a6Jq8E/R86fBFErK1hETVzgSEZx1aD/julRnhdSJFmgybJPg5ERuHUEkUOMGeojhp
 Umjjciy1uSLjPIpSdpcoQHvtIAMjQEJUqEHmYUNIy8q6nFhIOoHnbE/9qzH5y3cWhB
 a0WPtNJel6tKes73FrK5jRGKBUntjaPuBY23syF6ZLMjQbPigrv5NZ3A1PiNXC5m/4
 oI5hvqJTnCsQ1edUhQ3ZklP5RIpVInyVQFtCt4jFNCEx2rWqEQCPZHxehOiYttIUqR
 Zidvm+WoNGSNw==
Message-ID: <sashiko-outbox-174063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 5/5] rust: drm: Add JobQueue
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261016085724.1031766-7-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
 <20261016085724.1031766-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:12:34 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm: race in JobQueue completion misses updates and leaks capacity
- [High] drm: sleeping in atomic context due to dropping jobs under SpinLoc=
kIrq
- [High] drm: JobQueue fails to signal waiting jobs on drop and teardown ca=
using hangs
- [High] drm: UAF in JobQueue due to incorrect field drop order
- [High] drm: job_queue: oversized job permanently deadlocks FIFO queue
- [Medium] drm: JobQueue::teardown takes self by value making it uncallable=
 for PinnedDrop type
- [Medium] drm: Job::add_dependency causes a permanent mutable borrow makin=
g Job unusable
--

commit 6e3f97968faaf986f43b451fb90d4bf994878b66
Author: Philipp Stanner <phasta@kernel.org>

rust: drm: Add JobQueue

JobQueue is a pure Rust component that handles job submissions for GPUs
with firmware scheduling, i.e., GPUs that support one exclusive ring per
execution context.

> diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
> new file mode 100644
> index 0000000000000..66f98ee3df70b
> --- /dev/null
> +++ b/rust/kernel/drm/job_queue.rs
[ ... ]
> +impl<'a, T: JobQueueOps + Send + Sync> Job<'a, T> {
> +    /// Add a dependency for the job.
> +    ///
> +    /// A JobQueue will only push a job once `fence` has been signaled.
> +    pub fn add_dependency(&'a mut self, fence: &Fence) -> Result {

[Severity: Medium]
Can this cause a permanent mutable borrow of the job?

The method signature uses &'a mut self, where 'a is the lifetime parameter
of the Job struct itself. By mutably borrowing the job for its entire
remaining lifetime, it appears any subsequent attempt to call another method
on this job or pass it to JobQueue::submit(job) will result in a compile-ti=
me
error stating the value is already borrowed.

> +        let nr_of_deps =3D &raw const self.inner.nr_of_deps;
[ ... ]
> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for SubmitWorker<'_, T=
> {
> +    fn run(work: &ScopedWorkRef<Self>) {
> +        // Prevent work-item UAF if the JQ is trying to drop right now.
> +        let Some(jq_accessor) =3D work.jq.inner.try_access() else {
> +            return;
> +        };
> +
> +        let mut jq =3D jq_accessor.lock();
> +
> +        while let Some(mut job) =3D jq.as_mut().project().waiting_jobs.p=
op_front() {
> +            // While we didn't hold the lock below for `run_job()`, it c=
ould be
> +            // that a new job entered the waiting list which has an unfu=
lfilled
> +            // dependency.
> +            if job.nr_of_deps.load(Relaxed) > 0 {
> +                jq.waiting_jobs.push_front(job);
> +                break;
> +            }
> +            let new_capacity =3D jq.capacity as i64 - i64::from(job.cost=
);
> +            if new_capacity < 0 {
> +                jq.waiting_jobs.push_front(job);
> +                break;
> +            }

[Severity: High]
Could this permanently stall the FIFO queue if an oversized job is submitte=
d?

Since there doesn't appear to be validation in new_job rejecting a job with
a cost larger than the queue's total capacity, such a job could enter the
system. If capacity - cost < 0 for an oversized job, the worker pushes it
back to the front of the list and breaks. Because it sits at the front, no
subsequent jobs can run, and the queue capacity will never grow large enough
to run it, effectively deadlocking the queue.

> +            *jq.as_mut().project().capacity =3D new_capacity as u64;
> +
> +            let seqno =3D job
> +                .fence()
> +                .as_ref()
> +                .expect("fence not present")
> +                .as_fence()
> +                .seqno();
> +            let runnable_job =3D JobRunnable {
> +                seqno,
> +                data: job.fence().as_ref().expect("fence not present").d=
eref(),
> +            };
> +
> +            let jq_data =3D work.jq.fctx.deref().deref();
> +
> +            drop(jq); // Release lock.
> +            T::run_job(jq_data, runnable_job);
> +            jq =3D jq_accessor.lock(); // Retake lock.
> +
> +            // run_job() above needs to be called without lock protectio=
n. Thus,
> +            // it is possible that the driver instructed completion righ=
t before
> +            // we could re-take the lock.
> +            if jq.last_completed >=3D seqno {

[Severity: High]
Is it possible for this check to fail if a job completion races with the wo=
rker?

If the driver's interrupt handler calls complete_jobs_up_to_seqno(seqno)
while the lock is dropped during T::run_job, it will try to iterate over
running_jobs. Since the SubmitWorker hasn't pushed this job to
running_jobs yet, the loop in complete_jobs_up_to_seqno() is skipped,
and jq.last_completed isn't updated.

When SubmitWorker reacquires the lock, jq.last_completed >=3D seqno would
evaluate to false, and it would push the already-completed job into
running_jobs. This job would remain there forever, leaking its capacity
and hanging.

> +                if let Some(fence) =3D job.fence() {
> +                    fence.signal(Ok(()));
> +                } else {
> +                    panic!("fence not present.");
> +                }
> +
> +                // We drop this job here directly, from work_item contex=
t.
> +            } else {

[Severity: High]
Does dropping the job here violate atomic context constraints?

The JobQueue protects its inner state with a SpinLockIrq, meaning the CPU
is in atomic context here. The job implicitly drops at the end of the if
block while the spinlock guard is still held. Since dropping the job's
DriverFence involves an RCU grace period delay (typically calling
synchronize_rcu()), calling this sleeping function under a spinlock can
lead to a scheduling while atomic panic.

> +                jq.running_jobs.push_back(job);
> +            }
> +        }
> +    }
> +}
> +
> +#[pin_data]
> +struct DropWorker<'a, T: JobQueueOps + Send + Sync> {
> +    #[pin]
> +    jq: &'a JobQueue<'a, T>,
> +}
> +
> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for DropWorker<'_, T> {
> +    fn run(work: &ScopedWorkRef<Self>) {
[ ... ]
> +        let mut jq =3D jq_accessor.lock();
> +
> +        while let Some(_job) =3D jq.drop_list.pop_front() {
> +            // Droppy-dy-drop
> +        }

[Severity: High]
Similar to the issue above, does this drop the job in atomic context?

The _job is dropped at the end of the while loop block while jq
(the SpinLockIrq guard) is still held. This seems like it will call
synchronize_rcu() via the DriverFence drop logic, which sleeps and could
cause a panic.

> +    }
> +}
[ ... ]
> +#[pin_data(PinnedDrop)]
> +pub struct JobQueue<'a, T: JobQueueOps + Send + Sync> {
> +    #[pin]
> +    drop_worker: ScopedWork<DropWorker<'a, T>>,
> +    #[pin]
> +    // Revocable to prevent work-item UAF on `inner`.
> +    inner: Revocable<SpinLockIrq<JobQueueInner<'a, T>>>,
> +    #[pin]
> +    fctx: FenceContext<DriverDataWrapper<T>>,
> +    #[pin]
> +    submit_worker: ScopedWork<SubmitWorker<'a, T>>,
> +}

[Severity: High]
Does the declaration order of submit_worker introduce a use-after-free risk?

Rust drops struct fields in declaration order (top-to-bottom). Because
submit_worker is declared after inner and fctx, its work item will be
canceled and dropped last. If SubmitWorker::run executes in the narrow
window after inner and fctx are destroyed but before submit_worker
is dropped, it will try to access work.jq.inner and work.jq.fctx,
resulting in a use-after-free.

[ ... ]
> +    pub fn complete_jobs_up_to_seqno(&self, seqno: u64) {
> +        let needs_drop =3D core::mem::needs_drop::<T::JobDataType>();
> +        // unwrap() can't fire because `self` is valid.
> +        let jq =3D self.inner.try_access().unwrap();
> +        let mut jq_locked =3D jq.lock();
> +        let mut jq =3D jq_locked.as_mut().project();
> +
> +        if seqno < *jq.last_completed {
> +            return;
> +        }
> +
> +        while let Some(mut job) =3D jq.running_jobs.pop_front() {
> +            if job
> +                .fence()
> +                .as_mut()
> +                .expect("fence not present")
> +                .as_fence()
> +                .seqno()
> +                > seqno
> +            {
> +                jq.running_jobs.push_front(job);
> +                break;
> +            }
> +
> +            *jq.capacity +=3D u64::from(job.cost);
> +
> +            // This enables the SubmitWorker to complete a job that is n=
ot yet
> +            // in 'running_jobs', in case of a race against the lock.
> +            *jq.last_completed =3D seqno;

[Severity: High]
Is it intentional that these capacity and state updates are inside the loop?

If SubmitWorker::run is currently executing the job and hasn't yet pushed it
to running_jobs, running_jobs.pop_front() will return None. This skips
the loop entirely, so capacity is not restored and last_completed is not
updated. When SubmitWorker reacquires the lock, it won't see the completion.

[ ... ]
> +    pub fn teardown<E>(self, error: Error)
> +    where
> +        Error: From<E>,
> +    {

[Severity: Medium]
Will this function compile given self is passed by value?

JobQueue uses #[pin_data(PinnedDrop)] and contains structurally pinned
!Unpin fields like ScopedWork. Because it is !Unpin, it must be accessed
through pinned pointers. Taking self by value requires moving the JobQueue
out of its pinned pointer, which the Rust compiler rejects for !Unpin types.
It seems this method is uncallable dead code.

> +        let jq =3D self.inner.try_access().unwrap();
> +        let mut jq =3D jq.lock();
> +
> +        while let Some(mut job) =3D jq.running_jobs.pop_front() {
> +            if let Some(fence) =3D job.fence() {
> +                fence.signal(Err(error));
> +            } else {
> +                panic!("fence not present.");
> +            }
> +        }
> +    }

[Severity: High]
Does teardown silently drop waiting jobs without signaling them?

While it signals fences for running_jobs, it ignores waiting_jobs.
Since dma_fence instances do not signal themselves on drop, tasks waiting
on these fences will hang indefinitely.

> +}
> +
> +#[pinned_drop]
> +impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Revoke to prevent still existing DependencyWakers from kickin=
g the
> +        // SubmitWorker again before we could deregister them.
> +        let _ =3D self.inner.revoke();
> +    }
> +}

[Severity: High]
Does this drop implementation fulfill the documentation's guarantee?

The module documentation states: "Dropping a JobQueue results in all
remaining waiting and running jobs' fences being signaled with ECANCELED."
However, this drop logic does not iterate over waiting_jobs or
running_jobs to signal them. The fences will just be dropped, which will
cause any waiting tasks to hang indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016085724.1031=
766-2-phasta@kernel.org?part=3D5
